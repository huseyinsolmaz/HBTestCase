*** Settings ***
Library           Selenium2Library
Resource          ../Variables/ProductDetailVariables.robot
Resource          ../Variables/MainFunctions.robot


*** Keywords ***
Get Product Name
    Wait For Element  ${productName}
    ${name}  Get Text   ${productName}
    [Return]   ${name}