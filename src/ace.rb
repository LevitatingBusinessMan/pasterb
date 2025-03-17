
module ACE
    DIR = "/static/ace"
    ENTRY = "#{DIR}/ace.js"

    def ACE.modes
        @modes ||= Dir.glob("./#{DIR}/mode-*.js").map do |f|
            /mode-(?<mode>\w+).js/.match(f)["mode"]
        end
    end
end
