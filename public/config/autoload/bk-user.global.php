<?php

namespace Application;

use Application\Model\User as UserModel;
use Application\Form\Login as LoginForm;
use Zend\Stdlib\Hydrator\ObjectProperty as ObjectPropertyHydrator;
use Zend\Authentication\Result as AuthenticationResult;

$config = [
    'form-class' => LoginForm::class,
    'user-entity' => UserModel::class,
    'user-entity-hydrator' => ObjectPropertyHydrator::class,
    'identity_column' => 'email',
    'table' => 'user',

    'routes' => [
        'success' => '/home',
        'login' => '/login',
        'logout' => '/logout'
    ],
    'views' => [
        'login' => 'auth/login',
        'logout' => 'auth/logout'
    ],
    'messages' => [
        AuthenticationResult::FAILURE                    => "The Email address and/or Password is incorrect",
        AuthenticationResult::FAILURE_IDENTITY_NOT_FOUND => "The Email address and/or Password is incorrect",
        AuthenticationResult::FAILURE_IDENTITY_AMBIGUOUS => "The Email address and/or Password is incorrect",
        AuthenticationResult::FAILURE_CREDENTIAL_INVALID => "The Email address and/or Password is incorrect",
    ]
];

return ['bkuser\auth\config' => $config];