function fish_prompt
	set P_COLOR_1 1C1C1C
	if fish_is_root_user
		set P_COLOR_2 FF0000
	else
		set P_COLOR_2 0087FF
	end
	set P_COLOR_3 303030
	set P_COLOR_4 A8A8A8
	set P_COLOR_TEXT FFFFFF
	
	set_color $P_COLOR_TEXT -b $P_COLOR_1
	echo -n (date +[%H:%M:%S])

	set_color $P_COLOR_1 -b $P_COLOR_2
	echo -n \uE0B0 

	set_color $P_COLOR_TEXT -b $P_COLOR_2
	echo -n "" $USER ""

	set_color $P_COLOR_2 -b $P_COLOR_3
	echo -n \uE0B0
	
	set_color $P_COLOR_TEXT -b $P_COLOR_3
	echo -n "" (prompt_pwd -d 0) ""

	set_color $P_COLOR_3 -b normal
	echo -n \uE0B0

	set_color normal
	echo ""
	echo -n "\$ "
end
