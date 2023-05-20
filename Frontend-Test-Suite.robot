*** Settings ***
Library           SeleniumLibrary
Library           String

*** Test Cases ***
Add new TODO
    Open Browser    http://127.0.0.1:5500/todo.html    edge
    Input Text    //*[@id="todo"]    First TODO
    Input Text    //*[@id="desc"]    My very first TODO task
    ${titles}    Get WebElements    //td[@class='title']
    ${titlesCountBefore}    Set Variable    ${0}
    FOR    ${titleElement}    IN    @{titles}
        IF    "${titleElement.text}" == "First TODO"
            ${titlesCountBefore}=    Evaluate    ${titlesCountBefore} + 1
        END
    END
    ${descs}    Get WebElements    //td[@class='desc']
    ${descsCountBefore}    Set Variable    ${0}
    FOR    ${descElement}    IN    @{descs}
        IF    "${descElement.text}" == "My very first TODO task"
            ${descsCountBefore}=    Evaluate    ${descsCountBefore} + 1
        END
    END
    Click Button    //*[@id="todo-form"]/button
    ${temp}    Get Element Attribute    //*[@id="todo"]    value
    Should be Equal    ${EMPTY}    ${temp}
    ${temp}    Get Element Attribute    //*[@id="desc"]    value
    Should be Equal    ${EMPTY}    ${temp}
    ${titles}    Get WebElements    //td[@class='title']
    ${titlesCountAfter}    Set Variable    ${0}
    FOR    ${titleElement}    IN    @{titles}
        IF    "${titleElement.text}" == "First TODO"
            ${titlesCountAfter}=    Evaluate    ${titlesCountAfter} + 1
        END
    END
    ${descs}    Get WebElements    //td[@class='desc']
    ${descsCountAfter}    Set Variable    ${0}
    FOR    ${descElement}    IN    @{descs}
        IF    "${descElement.text}" == "My very first TODO task"
            ${descsCountAfter}=    Evaluate    ${descsCountAfter} + 1
        END
    END
    Should be Equal As Integers    ${titlesCountAfter}    ${titlesCountBefore + 1}
    Should be Equal As Integers    ${descsCountAfter}    ${descsCountBefore + 1}
    [Teardown]    Close Browser

Delete TODO
