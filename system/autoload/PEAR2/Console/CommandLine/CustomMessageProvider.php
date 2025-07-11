<?php

/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */

/**
 * This file is part of the PEAR2\Console\CommandLine package.
 *
 * PHP version 5
 *
 * LICENSE: This source file is subject to the MIT license that is available
 * through the world-wide-web at the following URI:
 * http://opensource.org/licenses/mit-license.php
 *
 * @category  Console
 * @package   PEAR2\Console\CommandLine
 * @author    David JEAN LOUIS <izimobil@gmail.com>
 * @author    Michael Gauthier <mike@silverorange.com>
 * @copyright 2007 David JEAN LOUIS, 2009 silverorange
 * @license   http://opensource.org/licenses/mit-license.php MIT License
 * @version   CVS: $Id: CustomMessageProvider.php 282427 2009-06-19 10:22:48Z izi $
 * @link      http://pear2.php.net/PEAR2_Console_CommandLine
 * @since     File available since release 1.1.0
 *
 * @filesource
 */

namespace PEAR2\Console\CommandLine;

/**
 * Common interfacefor message providers that allow overriding with custom
 * messages
 *
 * Message providers may optionally implement this interface.
 *
 * @category  Console
 * @package   PEAR2\Console\CommandLine
 * @author    David JEAN LOUIS <izimobil@gmail.com>
 * @author    Michael Gauthier <mike@silverorange.com>
 * @copyright 2007 David JEAN LOUIS, 2009 silverorange
 * @license   http://opensource.org/licenses/mit-license.php MIT License
 * @link      http://pear2.php.net/PEAR2_Console_CommandLine
 * @since     Interface available since release 1.1.0
 */
interface CustomMessageProvider
{
    // getWithCustomMesssages() {{{

    /**
     * Retrieves the given string identifier corresponding message.
     *
     * For a list of identifiers please see the provided default message
     * provider.
     *
     * @param string $code     The string identifier of the message
     * @param array  $vars     An array of template variables
     * @param array  $messages An optional array of messages to use. Array
     *                         indexes are message codes.
     *
     * @return string
     *
     * @see PEAR2\Console\CommandLine_MessageProvider
     * @see PEAR2\Console\CommandLine_MessageProvider\DefaultProvider
     */
    public function getWithCustomMessages(
        $code, $vars = array(), $messages = array()
    );

    // }}}
}
