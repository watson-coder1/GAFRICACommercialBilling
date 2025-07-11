<?php

/**
 *  PHP Mikrotik Billing (https://github.com/hotspotbilling/phpnuxbill/)
 *  by https://t.me/ibnux
 **/

class Password
{

    public static function _crypt($password)
    {
        return password_hash($password, PASSWORD_DEFAULT);
    }

    public static function _verify($user_input, $hashed_password)
    {
        // Support both old SHA1 and new bcrypt hashes for backward compatibility
        if (password_verify($user_input, $hashed_password)) {
            return true;
        }
        // Fallback to old SHA1 for existing passwords (DEPRECATED - auto-upgrade needed)
        if (sha1($user_input) == $hashed_password) {
            // Log security warning for SHA1 usage
            error_log("WARNING: SHA1 password detected for authentication - upgrade required");
            return true;
        }
        return false;
    }

    /**
     * Check if password needs to be upgraded from SHA1 to bcrypt
     * @param string $password
     * @return bool
     */
    public static function needsUpgrade($password)
    {
        // If it's not a bcrypt hash (doesn't start with $2y$), it needs upgrade
        return !password_get_info($password)['algo'];
    }
    public static function _uverify($user_input, $hashed_password)
    {
        if ($user_input == $hashed_password) {
            return true;
        }
        return false;
    }
    public static function _gen()
    {
        $pass = substr(str_shuffle(str_repeat('ABCDEFGHIJKLMNPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz@#!123456789', 8)), 0, 8);
        return $pass;
    }

    /**
     * verify CHAP password
     * @param string $realPassword
     * @param string $CHAPassword
     * @param string $CHAPChallenge
     * @return bool
     */
    public static function chap_verify($realPassword, $CHAPassword, $CHAPChallenge){
        $CHAPassword = substr($CHAPassword, 2);
        $chapid = substr($CHAPassword, 0, 2);
        $result = hex2bin($chapid) . $realPassword . hex2bin(substr($CHAPChallenge, 2));
        $response = $chapid . md5($result);
        return ($response != $CHAPassword);
    }
}
