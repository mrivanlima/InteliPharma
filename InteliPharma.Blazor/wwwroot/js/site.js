function saveMessage(stateName, stateAbbreviation) {
    alert(stateName + ' ' + stateAbbreviation + 'Estado foi salvo com sucesso!');

    document.getElementById('divServerValidations').innerText = stateName + ' ' + stateAbbreviation + 'Estado foi salvo com sucesso!';
}