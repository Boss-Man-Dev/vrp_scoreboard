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

$(document).keydown(function(e) {
    // open key ~
    if (e.keyCode == 192) {
        $.post("http://vrp_scoreboard/NUIFocusOff", JSON.stringify({}));
    }
	if (e.keyCode == 190) {
        $.post("http://vrp_scoreboard/NUIFocusOff_m", JSON.stringify({}));
    }
});

$(function()
{
	var arrow = document.getElementById('arrow');
	var mid = document.getElementById('extra');
	var exit = document.getElementById('exit');
	
	arrow.addEventListener('click', function(e) {
		mid.classList.toggle('extra');
	});

	exit.addEventListener('click', function(e) {
		$.post("http://vrp_scoreboard/NUIFocusOff", JSON.stringify({}));
	});
});

var visable = false;

$(function () {
	window.addEventListener('message', function (event) {

		switch (event.data.action) {
			
			case 'updatePlayerJobs':
				var jobs = event.data.jobs;

				$('#job1').html(jobs.job1);
				$('#job2').html(jobs.job2);
				$('#job3').html(jobs.job3);
				$('#job4').html(jobs.job4);
				
				$('#ex1').html(jobs.ex1);
				$('#ex2').html(jobs.ex2);
				$('#ex3').html(jobs.ex3);
				$('#ex4').html(jobs.ex4);
				
				$('#owner').html(jobs.owner);
				$('#admin').html(jobs.admin);
				$('#mod').html(jobs.mod);
				$('#user').html(jobs.user);
				
				break;
				
			default:
				break;
		}
	}, false);
});
