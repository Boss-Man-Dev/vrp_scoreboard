$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var data = event.data;
        if (data.type === "ui") {
            if (data.status == true) {
                display(true)
				document.getElementById("player__table").innerHTML = "";
            } else {
                display(false)
				document.getElementById("player__table").innerHTML = "";
            }
        }
		if (data.type === "table") {
            var main = $('#container')
			main.find('table').append("<tr></tr>");
			main.find('table').append(data.text);
        }
		if (data.type === "refresh") {
            document.getElementById("player__table").innerHTML = "";
        }
		if (data.type === "counts") {
			var counts = data.counts;
            $('#job_1-count').html(counts.job_1);
			$('#job_2-count').html(counts.job_2);
			$('#job_3-count').html(counts.job_3);
			$('#job_4-count').html(counts.job_4);
			
			$('#online_1-count').html(counts.online_1);
			$('#online_2-count').html(counts.online_2);
			$('#online_3-count').html(counts.online_3);
			$('#online_4-count').html(counts.online_4);
        }
    });
});

// Key Presses
$(function () {
    document.onkeyup = function (data) {
        if (data.which == 27) {	// ESC Key
            $.post('http://vrp_scoreboard/exit', JSON.stringify({}));
			document.getElementById("social_links").style.display = "none";
            return
        }
		if (data.which == 190) { // . mouse toggle key
            $.post('http://vrp_scoreboard/mouse', JSON.stringify({}));
            return
        }
    };
});

// Button Presses

$(function () {
    $("#exit_btn").click(function () {
        $.post('http://vrp_scoreboard/exit', JSON.stringify({}));
        document.getElementById("player__table").innerHTML = "";
		document.getElementById("social_links").style.display = "none";
        return
    })
	$("#refresh_btn").click(function () {
        $.post('http://vrp_scoreboard/refresh', JSON.stringify({}));
		document.getElementById("player__table").innerHTML = "";
		document.getElementById("social_links").style.display = "none";
		$("#container").hide();
        return
    })
    $("#social_btn").click(function () {
        document.getElementById("social_links").style.display = "block";
    })
    $("#social_exit_btn").click(function () {
        document.getElementById("social_links").style.display = "none";
    })
});