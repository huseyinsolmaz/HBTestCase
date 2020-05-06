*** Settings ***
Library           OperatingSystem
Library           RequestsLibrary
Resource          ../Facilities/APIFacilities.robot
Resource          ../Variables/MainFunctions.robot

Suite Setup
Test Teardown     MainFunctions.When Test Fail Take Screenshot


*** Test Cases ***

01.Test API
    Post Pet test
    Put Pet test
    Get Pet test
    Get Pet test Find Pet
    Post Pet test Update
    Delete Pet test


