//= require jquery3
//= require jquery_ujs
//= require turbolinks
//= require_tree .

//= require jquery-ui/widgets/sortable

$(document).ready(function() {

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
            //  if (ui.sender) {
                var newIndex = ui.item.index();
                var oldIndex = $(this).attr('data-oldindex');
                var oldCol = $(this).attr('data-oldcol');
                var newCol = ui.item.parent().parent().data('col');
                console.log("Old column: " + oldCol);
                console.log("New Column: " + newCol);
                $(this).removeAttr('data-oldindex');
                $(this).removeAttr('data-oldcol');
                $.ajax({
                    type: 'post',
                    url: window.location.pathname + '/sort',
                    data: {oldIndex: oldIndex,
                           newIndex: newIndex,
                           oldCol: oldCol,
                           newCol: newCol}
                }
              );
            // } else {
            //   console.log("OH NO SOMETHING WENT WRONG 584820293UR98374908238493Y4982731409824U90RU")
            // }
            // gets the new and old index then removes the temporary attribute
        }
    });
})
