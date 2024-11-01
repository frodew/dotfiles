if status is-interactive

    # Customize Hydro-Prompt
    function _hydro_postexec --on-event fish_postexec
        # Custom implementation without exit status
        set --global _hydro_status "$_hydro_newline$_hydro_color_prompt$hydro_symbol_prompt"
        # Replace ❱ with > because it does not work in nemo-terminal
        set --global hydro_symbol_prompt '>'
    end

    # Disable fish greeting
    set fish_greeting

    # Abbreviations
    abbr -a -- ... 'cd ../../'
    abbr -a -- .... 'cd ../../../'
    abbr -a -- ..... 'cd ../../../../'
    abbr -a -- l 'ls -alh'
    abbr -a -- c clear
    abbr -a -- q exit

    abbr -a -- v nvim

    abbr -a -- lg lazygit
end
