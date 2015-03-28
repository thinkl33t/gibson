<?php

return [
    'ldap' => [
        'host' => '127.0.0.1',
        'username' => 'CN=administrator,CN=Users,DC=hackspace,DC=internal',
        'password' => 'Password4LDAP',
        'bindRequiresDn' => false,
        'baseDn' => 'DC=hackspace,DC=internal',
        'accountCanonicalForm' => \Zend\Ldap\Ldap::ACCTNAME_FORM_PRINCIPAL,
        'accountDomainName' => 'hackspace.internal',
    ]
];