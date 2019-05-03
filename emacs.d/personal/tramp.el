(require 'tramp)
(add-to-list 'tramp-connection-properties
             (list (regexp-quote "phone:")
                   "remote-shell" "/system/comma/usr/bin/bash"))
