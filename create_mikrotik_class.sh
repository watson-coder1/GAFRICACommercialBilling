#!/bin/bash

echo "=== CREATING MIKROTIK CLASS ==="

# Create the Mikrotik.php class file
cat > system/devices/Mikrotik.php << 'EOF'
<?php

/**
 * MikroTik API Connection Class
 * Handles connection to MikroTik routers via API
 */
class Mikrotik
{
    private $host;
    private $username;
    private $password;
    private $socket;
    private $connected = false;

    public function __construct($host, $username, $password)
    {
        $this->host = $host;
        $this->username = $username;
        $this->password = $password;
    }

    public function connect()
    {
        try {
            $this->socket = @fsockopen($this->host, 8728, $errno, $errstr, 5);
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

echo "1. Created Mikrotik.php class file"

# Copy it to the container
docker cp system/devices/Mikrotik.php glinta-web:/var/www/html/system/devices/

# Set proper permissions
docker exec glinta-web chown www-data:www-data /var/www/html/system/devices/Mikrotik.php
docker exec glinta-web chmod 644 /var/www/html/system/devices/Mikrotik.php

echo "2. Deployed Mikrotik.php to container"

# Test if it loads
docker exec glinta-web php -r "
require_once '/var/www/html/system/devices/Mikrotik.php';
echo 'Mikrotik class loaded successfully!\n';
"

echo "=== MIKROTIK CLASS CREATED SUCCESSFULLY ==="
echo "Now run: ./fix_dashboard_sync.sh"