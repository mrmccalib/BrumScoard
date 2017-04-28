//= require jquery3
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery-ui/widgets/sortable


function showError(message) {
    $('#flashes').html('<div class="alert alert-danger">' + message + '</div>');
}

function clearError() {
    $('#flashes').empty();
}

$(document).on('turbolinks:load', function() {

    $.ajaxSetup({
        headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
    });

    $(".cards").sortable({
        group: 'cards',
        connectWith: ['.cards'],
        // pullPlaceholder: false,
        // revert: 300,

        start: function(e, ui) {
            // creates a temporary attribute on the element with the old index
            $(this).attr('data-oldindex', ui.item.index());
            $(this).attr('data-oldcol', ui.item.parent().parent().data('col'));
        },
        stop: function(e, ui) {

            var $cards = $(this);

            var newIndex = ui.item.index();
            var oldIndex = $cards.attr('data-oldindex');
            var oldCol = $cards.attr('data-oldcol');
            var newCol = ui.item.parent().parent().data('col');
            var id = ui.item.attr('id');

            // console.log("old column: " + oldCol);
            // console.log("new column: " + newCol);

            $cards.removeAttr('data-oldindex');
            $cards.removeAttr('data-oldcol');
            var updateRoute;
            if (oldCol == 0 || oldCol == 1) {
                updateRoute = 'sortstories';
            }
            else {
                updateRoute = 'sorttasks';
            }
            $.ajax({
                type: 'GET',
                dataType: 'json',
                url: window.location.pathname + '/' + updateRoute,
                data: {
                    itemID: id,
                    // oldIndex: oldIndex,
                    newIndex: newIndex,
                    // oldCol: oldCol,
                    newCol: newCol
                },
                success: function(data){
                    if (data)
                    {
                        $cards.sortable('cancel');
                        showError(data.message);
                    }
                    else {
                        clearError();
                    }
                },
                error: function(error) {
                    showError('AJAX response error!');
                    console.log("AJAX response error (check server console):");
                    console.log(error.getResponseHeader());
                }
            }
        );
    }
});
})
