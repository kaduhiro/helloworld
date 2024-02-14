define _prompt
	printf '\033[1;36m?\033[m %s \033[2;37m(%s)\033[m ' "$(1)" "$(2)" 1>&2; \
	read _prompt; \
	_prompt="$${_prompt:-$(3)}"
endef

define _prompts
	printf "$(2)" | nl 1>&2; \
	printf '\n\033[1;36m?\033[m %s \033[2;37m%s\033[m' "$(1)" 1>&2; \
	read _input_; \
	_prompts=; \
	: $${_prompts:=$$(printf "$(2)" | awk 'NR=="'$$_input_'"')}; \
	: $${_prompts:=$$(printf "$(2)" | grep -x "$$_input_")}; \
	: $${_prompts:=$$(printf "$(2)" | grep -m1 "$$_input_")}; \
	_prompts="$${_prompts:-$(3)}"
endef

define _success
	printf '\033[1;32m✔\033[m %s\n' "$(1)" 1>&2
endef

define _warning
	printf '\033[1;33m!\033[m %s\n' "$(1)" 1>&2
endef

define _failure
	printf '\033[1;31m✘\033[m %s\n' "$(1)" 1>&2
endef

define _debug
	printf '\033[2;37m%s\033[m\n' "$(1)" 1>&2
endef
