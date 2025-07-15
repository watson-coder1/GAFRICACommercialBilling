#!/bin/bash

echo "=== FIXING MIKROTIK PORT CONFIGURATION ==="

echo "1. Current configuration shows port 8080 in IP field"
echo "   IP: 10.0.0.2:8080"
echo "   Need to update MikroTik API class to use this port"

echo "2. Updating MikroTik API class to parse port from IP field..."

# Update the Mikrotik.php class to handle port in IP field
cat > system/devices/Mikrotik.php << 'EOF'
<?php

/**
 * MikroTik API Connection Class
 * Handles connection to MikroTik routers via API
 */
class Mikrotik
{
    private $host;
    private $port;
    private $username;
    private $password;
    private $socket;
    private $connected = false;

    public function __construct($host, $username, $password)
    {
        // Parse host and port from IP field (e.g., "10.0.0.2:8080")
        if (strpos($host, ':') !== false) {
            $parts = explode(':', $host);
            $this->host = $parts[0];
            $this->port = (int)$parts[1];
        } else {
            $this->host = $host;
            $this->port = 8728; // Default MikroTik API port
        }
        
        $this->username = $username;
        $this->password = $password;
    }

    public function connect()
    {
        try {
            $this->socket = @fsockopen($this->host, $this->port, $errno, $errstr, 10);
            if (!$this->socket) {
                return false;
            }

            // Login
            $this->write('/login');
            $ret = $this->read();
            
            if (isset($ret['trap'])) {
                return false;
            }

            $this->write('/login', array(
                '=name=' . $this->username,
                '=password=' . $this->password
            ));
            
            $ret = $this->read();
            
            if (isset($ret['done'])) {
                $this->connected = true;
                return true;
            }
            
            return false;
        } catch (Exception $e) {
            return false;
        }
    }

    public function comm($command, $arguments = array())
    {
        if (!$this->connected) {
            return false;
        }

        try {
            $this->write($command, $arguments);
            return $this->parseResponse($this->read());
        } catch (Exception $e) {
            return false;
        }
    }

    private function parseResponse($response)
    {
        $result = array();
        $current = array();
        
        foreach ($response as $line) {
            if (strpos($line, '=') === 0) {
                $parts = explode('=', substr($line, 1), 2);
                if (count($parts) === 2) {
                    $current[$parts[0]] = $parts[1];
                }
            } elseif ($line === 'done' || $line === 'trap') {
                if (!empty($current)) {
                    $result[] = $current;
                    $current = array();
                }
            }
        }
        
        if (!empty($current)) {
            $result[] = $current;
        }
        
        return $result;
    }

    private function write($command, $arguments = array())
    {
        $data = $this->encodeLength(strlen($command)) . $command;
        
        foreach ($arguments as $arg) {
            $data .= $this->encodeLength(strlen($arg)) . $arg;
        }
        
        $data .= chr(0);
        
        fwrite($this->socket, $data);
    }

    private function read()
    {
        $response = array();
        
        while (true) {
            $length = $this->readLength();
            
            if ($length === 0) {
                break;
            }
            
            $line = fread($this->socket, $length);
            
            if ($line === false) {
                break;
            }
            
            $response[] = $line;
        }
        
        return $response;
    }

    private function encodeLength($length)
    {
        if ($length < 0x80) {
            return chr($length);
        } elseif ($length < 0x4000) {
            return chr(0x80 | ($length >> 8)) . chr($length & 0xFF);
        } elseif ($length < 0x200000) {
            return chr(0xC0 | ($length >> 16)) . chr(($length >> 8) & 0xFF) . chr($length & 0xFF);
        } elseif ($length < 0x10000000) {
            return chr(0xE0 | ($length >> 24)) . chr(($length >> 16) & 0xFF) . chr(($length >> 8) & 0xFF) . chr($length & 0xFF);
        } else {
            return chr(0xF0) . chr(($length >> 24) & 0xFF) . chr(($length >> 16) & 0xFF) . chr(($length >> 8) & 0xFF) . chr($length & 0xFF);
        }
    }

    private function readLength()
    {
        $byte = ord(fread($this->socket, 1));
        
        if ($byte < 0x80) {
            return $byte;
        } elseif ($byte < 0xC0) {
            return (($byte & 0x7F) << 8) + ord(fread($this->socket, 1));
        } elseif ($byte < 0xE0) {
            return (($byte & 0x1F) << 16) + (ord(fread($this->socket, 1)) << 8) + ord(fread($this->socket, 1));
        } elseif ($byte < 0xF0) {
            return (($byte & 0x0F) << 24) + (ord(fread($this->socket, 1)) << 16) + (ord(fread($this->socket, 1)) << 8) + ord(fread($this->socket, 1));
        } else {
            return (ord(fread($this->socket, 1)) << 24) + (ord(fread($this->socket, 1)) << 16) + (ord(fread($this->socket, 1)) << 8) + ord(fread($this->socket, 1));
        }
    }

    public function __destruct()
    {
        if ($this->socket) {
            fclose($this->socket);
        }
    }
}
EOF

echo "3. Deploying updated MikroTik API class..."
docker cp system/devices/Mikrotik.php glinta-web:/var/www/html/system/devices/
docker exec glinta-web chown www-data:www-data /var/www/html/system/devices/Mikrotik.php
docker exec glinta-web chmod 644 /var/www/html/system/devices/Mikrotik.php

echo "4. Testing connection with port 8080..."
docker exec glinta-web php -r "
require_once '/var/www/html/init.php';
require_once '/var/www/html/system/devices/Mikrotik.php';

\$router = ORM::for_table('tbl_routers')->where('enabled', 1)->find_one();
if (\$router) {
    echo 'Testing connection to: ' . \$router->ip_address . ' (port will be parsed from IP)' . PHP_EOL;
    
    \$mikrotik = new Mikrotik(\$router->ip_address, \$router->username, \$router->password);
    
    if (\$mikrotik->connect()) {
        echo '✓ Connection successful to port 8080!' . PHP_EOL;
        
        // Test PPPoE
        \$pppoe = \$mikrotik->comm('/ppp/active/print');
        echo 'PPPoE active: ' . (is_array(\$pppoe) ? count(\$pppoe) : 'Failed') . PHP_EOL;
        
        // Test Hotspot
        \$hotspot = \$mikrotik->comm('/ip/hotspot/active/print');
        echo 'Hotspot active: ' . (is_array(\$hotspot) ? count(\$hotspot) : 'Failed') . PHP_EOL;
        
        // Show sample data
        if (is_array(\$pppoe) && count(\$pppoe) > 0) {
            echo 'Sample PPPoE user:' . PHP_EOL;
            print_r(\$pppoe[0]);
        }
        
        if (is_array(\$hotspot) && count(\$hotspot) > 0) {
            echo 'Sample Hotspot user:' . PHP_EOL;
            print_r(\$hotspot[0]);
        }
        
    } else {
        echo '✗ Connection failed to port 8080' . PHP_EOL;
    }
}
"

echo "=== MIKROTIK PORT FIX COMPLETE ==="