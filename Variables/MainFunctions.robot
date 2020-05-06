*** Settings ***
Library           Collections
Library           String
Library           Selenium2Library
Resource          ../Variables/Variables.robot
Library           FakerLibrary  locale=en_us
Library           DateTime

*** Keywords ***
Launch Browser
    [Arguments]  ${BROWSER}  ${Url}
    Run keyword and ignore error   Empty Directory     ${CURDIR}/../results/${TEST_NAME}
    Set Screenshot Directory  ${CURDIR}/../results/${TEST_NAME}
    ${userAgent}=  set variable  --user-agent="Mozilla/5.0 (WghrXkuMnF) AppleWebKit/5.0 Chrome/8.0 Safari/5.0"
    Open Browser    ${Url}    ${BROWSER}    alias=Main  ff_profile_dir=${userAgent}
    Maximize Browser Window

Wait For Element
    [Arguments]    ${element}    ${timeout}=20 sec    ${interval}=1 sec
    Wait Until Keyword Succeeds    ${timeout}    ${interval}    Page Should Contain Element    ${element}
    Capture Page Screenshot

Wait And Click Element
    [Arguments]    ${element}    ${timeout}=20 sec    ${interval}=1 sec
    Wait For Element    ${element}    ${timeout}    ${interval}
    Click Element    ${element}

Wait And Send Text
    [Arguments]    ${element}    ${text}    ${timeout}=20 sec    ${interval}=1 sec
    Wait For Element    ${element}    ${timeout}    ${interval}
    Input Text    ${element}    ${text}

Select IFrame
    [Arguments]    ${element}
    Wait For Element    ${element}
    Select Frame    ${element}

Focus Element
    [Arguments]    ${element}
    Set Focus To Element    ${element}

Wait And Focus Element
    [Arguments]    ${element}    ${timeout}=20 sec    ${interval}=1 sec
    Wait For Element    ${element}    ${timeout}    ${interval}
    focus element    ${element}

Create Random Text
    ${randomText}=    Generate Random String    8    [LOWER]
    [Return]  ${randomText}

Create Random Email
    ${randomText}=    Generate Random String    8    [LOWER]
    ${randomText}=    Set Variable    ${randomText}@gmail.com
    [Return]  ${randomText}

When Test Fail Take Screenshot
    Sleep  1s
#    Run Keyword And Ignore Error   Make Pptx    ${CURDIR}/../Tests/testresults/${TEST_NAME}
    Run Keyword If Test Failed    Capture Page Screenshot
    Run Keyword If Test Failed    Close Browser
    Run Keyword If Test Passed    Close Browser
    Close Browser

Scroll To Element
    [Arguments]    ${element}
    Wait For Element    ${element}
    Scroll Element Into View    ${element}

Wait Element And Get Text
    [Arguments]    ${element}    ${timeout}=20 sec    ${interval}=1 sec
    Wait For Element    ${element}    ${timeout}    ${interval}
    ${text}=  Get Text    ${element}
    [Return]   ${text}

Wait Element And Get Value
    [Arguments]    ${element}    ${timeout}=20 sec    ${interval}=1 sec
    Wait For Element    ${element}    ${timeout}    ${interval}
    Get Value    ${element}

Generate Random First Name
    ${randomFirstName}=    FakerLibrary.first_name
    [Return]    ${randomFirstName}

Generate Random Last Name
    ${randomLastname}=    FakerLibrary.first_name
     [Return]    ${randomLastname}

Generate Random Date
    ${randomDate}=    FakerLibrary.date    pattern=%d-%m-%Y
    ${randomDate}=    Remove String    ${randomDate}    -
      [Return]    ${randomDate}

Generate Random Phone
    ${randomPhone}=    FakerLibrary.Phone_number
    [Return]    ${randomPhone}

Generate Mail
    ${randomEmail}=    FakerLibrary.email
    [Return]    ${randomEmail}

Generate Random Text
    [Arguments]    ${nb_word}
    ${randomText}=    FakerLibrary.sentence    nb_words=${nb_word}
    [Return]    ${randomText}

Generate Random Number
    [Arguments]    ${digits}
    ${randomNumber}=    Random Number    ${digits}
    [Return]    ${randomNumber}

Delete Attribute By Id
    [Arguments]    ${locationId}    ${attribute}
    Execute Javascript    document.getElementById("${locationId}").removeAttribute("${attribute}");

Scroll To Location With JS
    [Arguments]    ${y}
    Execute Javascript    window.scrollTo(0,${y})

Current Date
    ${currentDate}=    Get Current Date    result_format=%Y %m %d
    [Return]    ${currentDate}

Create Birth Date Over 18
    ${currentDate}=  CurrentDate
    ${birthDate}=  Subtract Time From Date  ${currentDate}  7570 days
    ${birthDate}=  Remove String  ${birthDate}   00:00:00.000
    ${birthDate}=  Remove String  ${birthDate}   -
    ${birthDate}=    Replace String    ${birthDate}    ${space}    ${empty}
    [Return]    ${birthDate}

Erase Space Characters
    [Arguments]    ${element}
    ${element}=    Replace String    ${element}    ${space}    ${empty}
    [Return]    ${element}

Check Element Text
    [Arguments]   ${element}  ${expectedText}  ${checkMessage}   ${timeout}=30s
    Capture Page Screenshot
    Wait For Element  ${element}  ${timeout}
    Sleep  1s
    ${expectedText}=  convert to string  ${expectedText}
    ${status}    ${value}=    Run Keyword And Ignore Error    Element Text Should Be    ${element}    ${expectedText}
    Run Keyword If    '${status}'=='PASS'    log to console    \n${checkMessage} Success
    ...    ELSE    Fail    \nERROR-${checkMessage}-ERROR
    Capture Page Screenshot

Set Chrome Options
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    FOR    ${option}    IN    @{chrome_arguments}
    Call Method    ${options}    add_argument    ${option}
    END
    ${userAgent}=  set variable  --user-agent=Mozilla/5.0 (WghrXkuMnF) AppleWebKit/5.0 Chrome/8.0 Safari/5.0
    Call Method    ${options}  add_argument  ${userAgent}
    [Return]    ${options}

HeadlessChrome
    [Arguments]   ${browser}  ${URL}   ${alias}=None
    Set Screenshot Directory  ${CURDIR}/../Tests/testresults/${TEST_NAME}
    ${chrome_options}=    Set Chrome Options
    ${ws}=    Set Variable    window-size=1920,1200
    ${disableLogging}=    Set Variable    --log-level=3
    Call Method   ${chrome_options}    add_argument    ${ws}
    Call Method   ${chrome_options}    add_argument    ${disableLogging}
    Create Webdriver    ${browser}   ${alias}   chrome_options=${chrome_options}
    Go To  ${URL}
    Capture Page Screenshot

CreateChrome
    [Arguments]  ${browser}   ${URL}   ${alias}=None
    ${chrome_options}=    Set Chrome Options
    ${ws}=    Set Variable    window-size=1920,1200
    ${disableLogging}=    Set Variable    --log-level=3
    Call Method   ${chrome_options}    add_argument    ${ws}
    Call Method   ${chrome_options}    add_argument    ${disableLogging}
    run keyword if  'ff'=='${browser}'  Create Webdriver    ${browser}    ${alias}   chrome_options=${chrome_options}

    Create Webdriver    ${browser}    ${alias}   chrome_options=${chrome_options}
    Go To  ${URL}
    Capture Page Screenshot