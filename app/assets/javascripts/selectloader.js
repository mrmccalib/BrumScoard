$(document).on('turbolinks:load', function() {
    sprintsLoc = window.location.pathname.indexOf('sprints');
    sprintID = window.location.pathname.substring(sprintsLoc + 8);

    boardsLoc = window.location.pathname.indexOf('boards');
    boardSlashLoc = window.location.pathname.indexOf('/', boardsLoc + 7);
    boardID = window.location.pathname.substring(boardsLoc + 7, boardSlashLoc);

    $('#sprint_sprint_id').val(sprintID);

    $('#sprint_sprint_id').change(function() {
        console.log('hey');
        selection = $(this).find('option:selected').val();
        window.open('/boards/' + boardID + '/sprints/' + selection, '_self');
    });

})
