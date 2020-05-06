*** Settings ***
Library           Selenium2Library
Resource          ../Variables/HomePageVariables.robot
Resource          ../Variables/MainFunctions.robot


*** Keywords ***
Post Pet test
    ${headers}  set variable  Content-Type:application/json
    Create Session    alias    https://petstore.swagger.io/v2  verify=True
    &{headers}  Create Dictionary  Content-Type=application/json; charset=utf-8
    ${json}  OperatingSystem.Get File  ${CURDIR}\\..\\Variables\\pet.json
    ${resp}    Post Request    alias  uri=/pet    data=${json}    headers=${headers}
    run keyword if  '${resp.status_code}'=='200'  log to console  \npet post request succesfully trigered
    ...  ELSE   log  pet post request Failed  level=ERROR
    ${resp}    Post Request    alias  uri=/pet    data=${json}databreak    headers=${headers}
    run keyword if  '${resp.status_code}'=='500'  log to console  \npet post request Fail test Successfully trigered
    ...  ELSE   log   pet post fail request Failed  level=ERROR

Put Pet test
    ${headers}  set variable  Content-Type:application/json
    Create Session    alias    https://petstore.swagger.io/v2  verify=True
    &{headers}  Create Dictionary  Content-Type=application/json; charset=utf-8
    ${json}  OperatingSystem.Get File  ${CURDIR}\\..\\Variables\\pet.json
    ${resp}    PUT Request    alias  uri=/pet    data=${json}    headers=${headers}
    run keyword if  '${resp.status_code}'=='200'  log to console  \npet PUT request succesfully trigered
    ...  ELSE   log  pet PUT request Failed  level=ERROR
    ${resp}    PUT Request    alias  uri=/pet    data=${json}databreak    headers=${headers}
    run keyword if  '${resp.status_code}'=='500'  log to console  \npet PUT request Fail test Successfully trigered
    ...  ELSE   log   pet PUT fail request Failed  level=ERROR

Get Pet test
    ${headers}  set variable  Content-Type:application/json
    Create Session    alias    https://petstore.swagger.io/v2  verify=True
    &{headers}  Create Dictionary  Content-Type=application/json; charset=utf-8
    ${json}  OperatingSystem.Get File  ${CURDIR}\\..\\Variables\\pet.json
    ${resp}    Get Request    alias  uri=/pet/findByStatus?status=available     headers=${headers}
    run keyword if  '${resp.status_code}'=='200'  log to console  \npet Get request succesfully trigered
    ...  ELSE   log  pet Get request Failed  level=ERROR
    ${resp}    Get Request    alias  uri=/pet/findByStatus?status=   headers=${headers}
    run keyword if  '${resp.text}'=='[]'  log to console  \npet Get request Fail test Successfully trigered
    ...  ELSE   log  pet Get fail request Failed  level=ERROR

Get Pet test Find Pet
    ${headers}  set variable  Content-Type:application/json
    Create Session    alias    https://petstore.swagger.io/v2  verify=True
    &{headers}  Create Dictionary  Content-Type=application/json; charset=utf-8
    ${json}  OperatingSystem.Get File  ${CURDIR}\\..\\Variables\\pet.json
    ${resp}    Get Request    alias  uri=pet/1     headers=${headers}
    run keyword if  '${resp.status_code}'=='200'  log to console  \npet Get request succesfully trigered(Find Pet)
    ...  ELSE   log   pet Get request Failed(Find Pet)   level=ERROR
    ${resp}    Get Request    alias  uri=pet/5564   headers=${headers}
    run keyword if  '${resp.status_code}'=='404'  log to console  \npet Get request Fail test Successfully trigered(Find Pet)
    ...  ELSE   log  pet Get fail request Failed(Find Pet)  level=ERROR


Delete Pet test
    ${headers}  set variable  Content-Type:application/json
    Create Session    alias    https://petstore.swagger.io/v2  verify=True
    &{headers}  Create Dictionary  Content-Type=application/json; charset=utf-8
    ${resp}    Delete Request    alias  uri=pet/1     headers=${headers}
    run keyword if  '${resp.status_code}'=='200'  log to console  \npet Delete request succesfully trigered
    ...  ELSE   log   pet Delete request Failed  level=ERROR
    ${resp}    Get Request    alias  uri=pet/5564   headers=${headers}
    run keyword if  '${resp.status_code}'=='404'  log to console  \npet Delete request Fail test Successfully trigered
    ...  ELSE   log  pet Delete fail request Failed  level=ERROR


Post Pet test Update
    ${headers}  set variable  Content-Type:application/x-www-form-urlencoded
    Create Session    alias    https://petstore.swagger.io/v2  verify=True
    &{headers}  Create Dictionary  Content-Type=application/json; charset=utf-8
    ${json}  Create Dictionary  name=selam  status=Pending
    ${resp}    Post Request    alias  uri=/pet    data=${json}    headers=${headers}
    run keyword if  '${resp.status_code}'=='200'  log to console  \npet post request succesfully trigered (Pet Update)
    ...  ELSE   log   pet post request Failed (Pet Update)  level=ERROR
    ${resp}    Post Request    alias  uri=/pet/1    data=name=selam status=Pending    headers=${headers}
    run keyword if  '${resp.status_code}'=='415'  log to console  \npet post request Fail test Successfully trigered (Pet Update)
    ...  ELSE   log   pet post fail request Failed (Pet Update)  level=ERROR
