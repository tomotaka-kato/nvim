Vim�UnDo� �%j5���\3%�{��%��!H���͌0�   "                                  b��    _�                             ����                                                                                                                                                                                                                                                                                                                                                             b�_     �                   �               5��                                         �       5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b�`    �                  5��                                                  5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b��     �          	       �              5��                                                  �                                                  5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             b��     �          	      -- LSP本体の設定5��                                              �                                                5�_�                    	       ����                                                                                                                                                                                                                                                                                                                                                             b��     �   	               �   	            5��    	                                           �    	                                           �    
                   !   	              !       5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             b��     �   
              !-- 補完プラグインの設定5��    
                    !                    �    
                                        5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             b��     �                 -- �               �               �               5��                          (                     �                         +                     �                         (                    5�_�      	                     ����                                                                                                                                                                                                                                                                                                                                                             b��     �                  �               5��                          A                     �                          A                     �                         L                     �                          M                     �                         M                    5�_�                 	          ����                                                                                                                                                                                                                                                                                                                                                             b��    �               	�             5��                          M                     �                          M                     5�_�   	      
                 ����                                                                                                                                                                                                                                                                                                                                                             b�i     �               	source5��                          M                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             b�i    �               source5��                          M                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             b��     �               	source5��                         T                     �                        T                    5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             b��     �               	sources = cmp.config.sources()5��                         k                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             b��     �               !	sources = cmp.config.sources({})5��                        l                     �                          m                     �                         m                     5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             b��     �                5��                          m                     �                        �                     �                         �                     �                        �                     �                         �                     �                        �                    �                        �                     �                         �                     �                        �                    �                        �                     �                      	   �              	       5�_�                       
    ����                                                                                                                                                                                                                                                                                                                                                             b��     �                		{ name = 5��                          �                     5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             b��    �               		{ name = 'cmdline' },5��                         �                     5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        b�Z    �                   �               �                 -- LSP本体設定   2local lsp_installer = require "nvim-lsp-installer"   %local lspconfig = require "lspconfig"   lsp_installer.setup()   Afor _, server in ipairs(lsp_installer.get_installed_servers()) do      lspconfig[server.name].setup {       on_attach = on_attach,     }   end       -- 補完プラグイの設定   local cmp = require'cmp'   cmp.setup({   	sources = cmp.config.sources({   		{ name = 'nvim_lsp' },   		{ name = 'buffer' },   		{ name = 'path' },   		{ name = 'cmdline' }   	})   })5��                                  �             �                                            �      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                V       b��    �             �             �                (		["<C-Space>"] = cmp.mapping.complete()5��                          �      )               �                          �              �       5�_�                            ����                                                                                                                                                                                                                                                                                                                                                 V        b��     �              �             �               	mapping = {   -		["<C-p>"] = cmp.mapping.select_prev_item(),   -		["<C-n>"] = cmp.mapping.select_next_item(),   %		["<C-l>"] = cmp.mapping.complete(),   	},5��                          �      U               �                          �              �       5�_�   	              
          ����                                                                                                                                                                                                                                                                                                                                                             b�      �               source5��                          M                     5��