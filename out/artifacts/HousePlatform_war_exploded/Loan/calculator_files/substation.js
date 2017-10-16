//二手房JS
if(!substation){
	substation = '杭州';
}
document.write('<div id="substation_now" class="msmo"><div class="fl"><b>' + substation + '</b></div><div class="fl"><div class="top_button"></div></div></div><div id="substation_list" class="msmo_1"><ul><li><a href="http://www.kfw001.com/">杭州</a></li><li><a href="http://wenzhou.kfw001.com/">温州</a></li><li><a href="http://ningbo.kfw001.com/">宁波</a></li><li><a href="http://jinhua.kfw001.com/">金华</a></li><li><a href="http://shaoxing.kfw001.com/">绍兴</a></li><li><a href="http://jiaxing.kfw001.com/">嘉兴</a></li><li><a href="http://taizhou.kfw001.com/">台州</a></li><li><a href="http://quzhou.kfw001.com/">衢州</a></li><li><a href="http://huzhou.kfw001.com/">湖州</a></li></ul></div>');

$(function(){
	$('.substation').bind('mouseover',function(){
		$('#substation_list').show();
	}).bind('mouseout',function(){
		$('#substation_list').hide();
	});
});
