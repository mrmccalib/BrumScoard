//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

//= require jquery-ui/widgets/sortable

$(document).ready(function() {
    // var columns = $('.column').each(function() {
    //     console.log(this);
    //     options = {
    //         draggable: '.card',
    //         animation: 150,
    //        onSort: function (/**Event*/evt) {
    //            var item = evt.item;
    //            console.log(evt.oldIndex);
    //            console.log(evt.newIndex);
    //            $.ajax({
    //               url: window.location.pathname + '/sort',
    //               type: 'post',
    //               data: {oldIndex: evt.oldIndex, newIndex: evt.newIndex}
    //             });
    //        }
    //     };
    //     var sortable = Sortable.create(this, options);
    // });

    $(".column").sortable({
        group: 'column',
        // pullPlaceholder: false,
        // revert: 300,

        start: function(e, ui) {
            // creates a temporary attribute on the element with the old index
            $(this).attr('data-oldindex', ui.item.index());
        },
        update: function(e, ui) {
            // gets the new and old index then removes the temporary attribute
            var newIndex = ui.item.index();
            var oldIndex = $(this).attr('data-oldindex');
            $(this).removeAttr('data-oldindex');
           $.ajax({
              url: window.location.pathname + '/sort',
              type: 'post',
              data: {oldIndex: oldIndex, newIndex: newIndex}
            });
        }
    });
})
