#Install

Go to https://www.python.org/ and download Python 3.7.x version as shown below and install it.

Open command prompt and run below command.

You have to install robot framework

Open CMD

pip install robotframework
then Libraries

Selenium2library for UI automation

FakerLibrary for generate random data

python-pptx for generate PPTX file

pip install python-pptx
pip install robotframework
pip install robotframework-selenium2library
pip install robotframework-faker
Install Firefox

https://github.com/mozilla/geckodriver/releases
Or

Install Chrome

https://chromedriver.chromium.org/downloads
You are ready to run your Test case For UI Tests

cd  ${YOUR_PATH}
robot -d results tests/project.robot
If You want to change browser you have to add command

    --variable BROWSER:Chrome
    robot -d results --variable BROWSER:ff TestSuites/ApiTestSuites.robot
    
To RUN Test Cases

To Main Test Cases

    robot -d results --variable BROWSER:ff TestSuites/MainTestSuites.robot
    
To API Test Cases

    robot -d results --variable BROWSER:ff TestSuites/ApiTestSuites.robot
