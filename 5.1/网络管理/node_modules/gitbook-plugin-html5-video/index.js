function getHtml5Video(block){

    var url = block.body;

    var width = block.kwargs.width || '100%';
    var height = block.kwargs.height || '100%';
    var loop = block.kwargs.loop || '';
    var controls = block.kwargs.controls || '';

    return '<video src="'+url+'" width="'+width+'" height="'+height+'" controls="'+controls+'" loop="'+loop+'"></video>';
}

/*
{%video%, width = "100%", height = "74", loop = "loop", controls = "controls"} http://**.mp4 {%video%}
*/
module.exports = {
    blocks: {
        video: {
            process: function(block) {
                return getHtml5Video(block);
            }
        }
    }
};
