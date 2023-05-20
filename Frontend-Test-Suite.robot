*** Settings ***
Library           SeleniumLibrary
Library           String

*** Test Cases ***
Add new TODO
    Open Browser    http://127.0.0.1:5500/todo.html    edge
    ${title}=    Generate Random String    20    [LETTERS]
    ${desc}=    Generate Random String    64    [LETTERS]
    Input Text    //*[@id="todo"]    ${title}
    Input Text    //*[@id="desc"]    ${desc}
    Click Button    //*[@id="todo-form"]/button
    ${temp}    Get Element Attribute    //*[@id="todo"]    value
    Should be Equal    ${EMPTY}    ${temp}
    ${temp}    Get Element Attribute    //*[@id="desc"]    value
    Should be Equal    ${EMPTY}    ${temp}
    ${insertedTitle}    Get WebElement    //tr[last()]/td[2]
    ${insertedDesc}    Get WebElement    //tr[last()]/td[3]
    Should Be Equal As Strings    ${insertedTitle.text}    ${title}
    Should Be Equal As Strings    ${insertedDesc.text}    ${desc}
    [Teardown]    Close Browser

Delete TODO
    Open Browser    http://127.0.0.1:5500/todo.html    edge
   Open Browser    http://127.0.0.1:5500/todo.html    edge
    ${firstTitle}=    Generate Random String    20    [LETTERS]
    ${firstDesc}=    Generate Random String    64    [LETTERS]
    Input Text    //*[@id="todo"]    ${firstTitle}
    Input Text    //*[@id="desc"]    ${firstDesc}
    Click Button    //*[@id="todo-form"]/button


    ${title}=    Generate Random String    20    [LETTERS]
    ${desc}=    Generate Random String    64    [LETTERS]
    Input Text    //*[@id="todo"]    ${title}
    Input Text    //*[@id="desc"]    ${desc}
    Click Button    //*[@id="todo-form"]/button

    ${temp}    Get Element Attribute    //*[@id="todo"]    value
    Should be Equal    ${EMPTY}    ${temp}
    ${temp}    Get Element Attribute    //*[@id="desc"]    value
    Should be Equal    ${EMPTY}    ${temp}
    ${insertedTitle}    Get WebElement    //tr[last()]/td[2]
    ${insertedDesc}    Get WebElement    //tr[last()]/td[3]
    Should Be Equal As Strings    ${insertedTitle.text}    ${title}
    Should Be Equal As Strings    ${insertedDesc.text}    ${desc}
    
    ${deleteButton}    Get WebElement    //tr[last()]/td[last()]/button
    Click Button    ${deleteButton}
    ${insertedTitle}    Get WebElement    //tr[last()]/td[2]
    ${insertedDesc}    Get WebElement    //tr[last()]/td[3]
    Should Be Equal As Strings    ${insertedTitle.text}    ${firstTitle}
    Should Be Equal As Strings    ${insertedDesc.text}    ${firstDesc}

    [Teardown]    Close Browser
