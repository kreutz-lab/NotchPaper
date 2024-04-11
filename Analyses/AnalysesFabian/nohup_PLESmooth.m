try
    parpool('local')
end

cd /home/ckreutz/final_model_with_spdef/
addpath('/home/ckreutz/d2d/arFramework3/')
arInit


arLoad('20221215T174237_ple')
pleSmooth
arSave('current')

exit
