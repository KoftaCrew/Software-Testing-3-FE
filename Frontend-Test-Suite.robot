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
    
    ${deleteButton}    Get WebElement    //tr[last()]/td[last()]/button
    Click Button    ${deleteButton}
    ${insertedTitle}    Get WebElement    //tr[last()]/td[2]
    ${insertedDesc}    Get WebElement    //tr[last()]/td[3]
    Should Be Equal As Strings    ${insertedTitle.text}    ${firstTitle}
    Should Be Equal As Strings    ${insertedDesc.text}    ${firstDesc}

    [Teardown]    Close Browser

Update completion
    Open Browser    http://127.0.0.1:5500/todo.html    edge
    ${firstTitle}=    Generate Random String    20    [LETTERS]
    ${firstDesc}=    Generate Random String    64    [LETTERS]
    Input Text    //*[@id="todo"]    ${firstTitle}
    Input Text    //*[@id="desc"]    ${firstDesc}
    Click Button    //*[@id="todo-form"]/button


    ${secondTitle}=    Generate Random String    20    [LETTERS]
    ${secondDesc}=    Generate Random String    64    [LETTERS]
    Input Text    //*[@id="todo"]    ${secondTitle}
    Input Text    //*[@id="desc"]    ${secondDesc}
    Click Button    //*[@id="todo-form"]/button

    Select Checkbox    //tr[last()]/td[4]/input

    Reload Page
    Checkbox Should Be Selected    //tr[last()]/td[4]/input
    Checkbox Should Not Be Selected    //tr[last() - 1]/td[4]/input
    [Teardown]    Close Browser

All TODO
    Open Browser    http://127.0.0.1:5500/todo.html    edge
    ${firstTitle}=    Generate Random String    20    [LETTERS]
    ${firstDesc}=    Generate Random String    64    [LETTERS]
    Input Text    //*[@id="todo"]    ${firstTitle}
    Input Text    //*[@id="desc"]    ${firstDesc}
    Click Button    //*[@id="todo-form"]/button


    ${secondTitle}=    Generate Random String    20    [LETTERS]
    ${secondDesc}=    Generate Random String    64    [LETTERS]
    Input Text    //*[@id="todo"]    ${secondTitle}
    Input Text    //*[@id="desc"]    ${secondDesc}
    Click Button    //*[@id="todo-form"]/button

    ${thridTitle}=    Generate Random String    20    [LETTERS]
    ${thridDesc}=    Generate Random String    64    [LETTERS]
    Input Text    //*[@id="todo"]    ${thridTitle}
    Input Text    //*[@id="desc"]    ${thridDesc}
    Click Button    //*[@id="todo-form"]/button

    Select Checkbox    //tr[last()]/td[4]/input
    Select Checkbox    //tr[last() - 1]/td[4]/input

    ${elementsBeforeClick}    Get WebElements    //tbody[id="todo-table"]/tr

    Click Button    //html/body/div/div/div[2]/button[1]

    ${elementsAfterClick}    Get WebElements    //tbody[id="todo-table"]/tr
    ${size}=    Get Length    ${elementsBeforeClick}
    FOR    ${i}    IN RANGE    ${size}
        Should Be Equal    ${elementsAfterClick[${i}]}    ${elementsBeforeClick[${i}]}
    END


    [Teardown]    Close Browser

Get completed
    Open Browser    http://127.0.0.1:5500/todo.html    edge
    ${firstTitle}=    Generate Random String    20    [LETTERS]
    ${firstDesc}=    Generate Random String    64    [LETTERS]
    Input Text    //*[@id="todo"]    ${firstTitle}
    Input Text    //*[@id="desc"]    ${firstDesc}
    Click Button    //*[@id="todo-form"]/button


    ${secondTitle}=    Generate Random String    20    [LETTERS]
    ${secondDesc}=    Generate Random String    64    [LETTERS]
    Input Text    //*[@id="todo"]    ${secondTitle}
    Input Text    //*[@id="desc"]    ${secondDesc}
    Click Button    //*[@id="todo-form"]/button

    ${thridTitle}=    Generate Random String    20    [LETTERS]
    ${thridDesc}=    Generate Random String    64    [LETTERS]
    Input Text    //*[@id="todo"]    ${thridTitle}
    Input Text    //*[@id="desc"]    ${thridDesc}
    Click Button    //*[@id="todo-form"]/button

    Sleep    1

    Select Checkbox    //tr[last()]/td[4]/input
    Select Checkbox    //tr[last() - 1]/td[4]/input

    Click Button    //html/body/div/div/div[2]/button[2]

    ${checkboxes}    Get WebElements    //input[contains(@type, 'checkbox')]

    FOR    ${checkbox}    IN    @{checkboxes}
        Checkbox Should Be Selected    ${checkbox}
    END

    [Teardown]    Close Browser


