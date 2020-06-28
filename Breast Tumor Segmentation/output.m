function [imkmeans,ak,imthres,afcmtresh,imfuzzy,afcm]=output(im)
[imkmeans,ak]=ariekmeans(im);
[imthres,afcmtresh]=ariethres(im);
[imfuzzy,afcm]=ariefcm(im);
end