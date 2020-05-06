*** Settings ***
Library           Selenium2Library
Resource          ../Variables/ShopingCardVariables.robot
Resource          ../Variables/MainFunctions.robot


*** Keywords ***
Check Products On Last Seen
    [Arguments]     ${text}
    Wait For Element  ${recommendedCards}
    Scroll To Element   ${seenProductMainPath}
    FOR    ${index}    IN RANGE    1  4
    ${productName}  Get Element Attribute  ${seenProductMainPath}\[${index}\]//h3  title
    ${status}  ${value}  run keyword and ignore error  Should Be Equal As Strings    ${productName}    ${text}
    Exit For Loop If  '${status}'=='PASS'
    END
    RUN KEYWORD IF  '${status}'=='PASS'  log to console  Product Found
    ...  ELSE  FAIL  Product can't found