*** Settings ***
Library           Selenium2Library
Resource          ../Variables/LoginPageVariables.robot


*** Keywords ***
Login HB
    Open Login Page
    Enter Username
    Enter Password
    Click Login Button
    Check Login Status

Open Login Page
    Wait And Click Element      ${myAccount}
    Wait Until Element Is Visible  ${loginLink}
    Wait And Click Element  ${loginLink}

Enter Username
    Wait And Send Text  ${emailInput}   ${userMail}

Enter Password
    Wait And Send Text  ${passwordInput}   ${password}

Click Login Button
    Wait And Click Element  ${loginButton}

Check Login Status
    Check Element Text   ${loginName}  ${userFullName}   Login