require "cgi"
class PasteRB
    def call env
        $cgi = CGI.new
        [200, {}, ["Hello World"]]
    end
end

run PasteRB.new
