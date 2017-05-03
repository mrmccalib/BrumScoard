$(document).on('turbolinks:load', function() {
    sprintsLoc = window.location.pathname.indexOf('sprints');
    sprintID = window.location.pathname.substring(sprintsLoc + 8);

    boardsLoc = window.location.pathname.indexOf('boards');
    boardSlashLoc = window.location.pathname.indexOf('/', boardsLoc + 7);
    boardID = window.location.pathname.substring(boardsLoc + 7, boardSlashLoc);

    statesLoc = window.location.pathname.indexOf('states');
    stateSlashLoc = window.location.pathname.indexOf('/', statesLoc + 7);
    stateID = window.location.pathname.substring(statesLoc + 7, stateSlashLoc);

    $('#sprint_sprint_id').val(sprintID);
    $('#state_state_id').val(stateID);

    $('#sprint_sprint_id').change(function() {
        selection = $(this).find('option:selected').val();
        window.open('/boards/' + boardID + '/states/' + stateID + '/sprints/' + selection, '_self');
    });

    $('#state_state_id').change(function() {
        selection = $(this).find('option:selected').val();
        sprintID = -1;
        $.ajax({
            type: 'GET',
            dataType: 'json',
            url: '/boards/' + boardID + '/states/' + selection + '/latestsprint',
            data: {},
            success: function(data) {
                if (data) {
                    if (data.sprint_id) {
                        sprintID = data.sprint_id;
                        window.open('/boards/' + boardID + '/states/' + selection + '/sprints/' + sprintID, '_self');
                    }
                    else {
                        showError('Unhandled response type!');
                    }
                }
                else {
                    showError('No AJAX data!');
                }
            },
            error: function(error) {
                showError('AJAX response error!');
                console.log("AJAX response error (check server console):");
                console.log(error.getResponseHeader());
            }
        });
    });
})
