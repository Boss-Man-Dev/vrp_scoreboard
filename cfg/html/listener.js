/* Need Help? Join my discord @ discord.gg/yWddFpQ */ 
$(function()
{
    window.addEventListener('message', function(event)
    {
        var data = event.data;
        var wrap = $('#wrap');
		/* additional style info is in css under tr */ 
        wrap.find('table').append("<tr></tr>");
        if (data.meta && data.meta == 'close')
        {
            document.getElementById("ptbl").innerHTML = "";		/* player table */ 
            $('#wrap').hide();
            return;
        }
        wrap.find('table').append(data.text);
        $('#wrap').show();
    }, false);
});

var visable = false;

$(function () {
	window.addEventListener('message', function (event) {

		switch (event.data.action) {
			
			case 'updatePlayerJobs':
				var jobs = event.data.jobs;

				$('#ems').html(jobs.ems);
				$('#police').html(jobs.police);
				$('#taxi').html(jobs.taxi);
				$('#mechanic').html(jobs.mechanic);
				
				$('#cardealer').html(jobs.cardealer);
				$('#estate').html(jobs.estate);
				
				$('#owner').html(jobs.owner);
				$('#admin').html(jobs.admin);
				$('#mod').html(jobs.mod);
				
				break;
				
			default:
				break;
		}
	}, false);
});
