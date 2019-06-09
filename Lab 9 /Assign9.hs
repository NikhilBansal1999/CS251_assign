import System.IO
import Data.Char
import Data.List.Split

insertAt :: a -> [a] -> Integer -> [a]
insertAt a [] n = a : []
insertAt a b 1 = a : b
insertAt a b n = head(b) : ( insertAt a (tail b) (n-1))

incrrange :: [Int] -> (Int, Int) -> [Int]
incrrange a (0, n) = [(a !! x) + 1 | x <- [0..n] ] ++ [ a !! x | x <- [(n+1)..(length(a)-1)]]
incrrange a (b, c) = (head a) : (incrrange (tail a) (b-1, c-1))

strict_question a (b, c) = incrrange a (b-1, c-1)

combination :: Int -> [a] -> [[a]]
combination n [] = []
combination 1 a = [ [a !! x] | x <- [0..(length(a)-1)]]
combination n a = [ (head a) : x | x <- (combination (n-1) (tail a))] ++ (combination n (tail a))

present_in_list :: (Eq b) => b ->[b] -> Bool
present_in_list elem [] = False
present_in_list elem lst = if (elem == (lst !! 0)) then True else (present_in_list elem (tail lst))

unique_list :: (Eq b) => [b] -> [b] -> [b]
unique_list lst [] = lst
unique_list lst arr = if (present_in_list (arr !! 0) lst) then (unique_list lst (tail arr)) else (unique_list ((head arr) : lst) (tail arr))

cipher = "6;’) *‡; 7*‡]08†38 ;45; 6) ).(85†6*3 ;4(‡?34 ;48 6*;8(*8;, 6; 6) 6*1‡(95;6‡* ]46-4 6) 286*3 ?)8†, 5*† ;45; ;‡‡, ‡* 5 ;89.‡(5(: 25)6) ‡*0:. ]45; ]8 16*† ‡*8 -06-7 5]5: 6) ‡*0: 6*1‡(95;6‡*: 15-;) ;45; ]8 (85† 5*† ?*†8();5*† 2?; †‡ *‡; (8;56*.\n\n281‡(8 ;48 5†¶8*; ‡1 ;48 -:28( ]‡(0†, 61 )‡98‡*8 ]5*;8† ;‡ 16*† ‡?; 52‡?; 5 -‡?*;(: ;48: ]6)48† ;‡ ¶6)6;, ;48: ]8*; ;‡ 062(5(68) 5*† 2‡‡7 );‡(8); ;48: (85† ;(5¶80 3?6†8) 5*† (8)85(-48† 85-4 5*† 8¶8(: †8;560 52‡?; ;48 -‡?*;(:. ;48: ]8*; ‡?; 5*† )5] ;48 ]‡(0†, $?8);6‡*8† 6;, ;(68† ;‡ ?*†8();5*† 6;. ;48: *8¶8( 3‡‡308† 6;, ;(:6*3 ;‡ -‡*)?98 500 )‡(;) ‡1 †8;560) 6* 5 ).5* ‡1 15 96*?;8).\n\n6*†88†, (85†6*3 ;48 52);(5-; ‡1 5 (8)85(-4 .5.8( ;‡ -6;8 6; 6) *‡; 8*‡?34. ‡*06*8 (8)85(-4 – 8¶8* 61 :‡? ?)8 ‡*06*8 2‡‡7), 6) *‡; 8*‡?34. :‡? *88† ;‡ 3‡ ‡?;. :‡?( .4:)6-50 )801 *88†) ;‡ 8¢.8(68*-8 ;48 (850 ]‡(0†, ;48 7*‡]08†38. ;48(8 )4‡?0† 28 6998()6‡*. 5 305*-8 5; ;48 ](6;;8* ]‡(† ;4(‡?34 5 )-(88* 6) *‡; 8*‡?34.\n\n;48 6*;8(*8; 6) .(‡1‡?*†0: 05-76*3 ]48* 6; -‡98) ;‡ -5;8(6*3 ;‡ ;48 3(‡];4 ‡1 4?95* 286*3). 6; †‡8) *‡;46*3 1‡( ;48 4?95* 6*;8008-; ‡( ;48 4?95* ).6(6;; 500 6; †‡8) 6) .(‡¶6†8 ?) ]6;4 *?98(‡?) ;:.8) ‡1 6*1‡(95;6‡*. ¶8(: 18] 9634; (8506)8 6;, 2?; ;46) 480.1?0 ;‡‡0 ;45; ]8 -500 ;48 6*;8(*8; 6) 5 -?()8 6* )8¶8(50 ]5:). 500 ;45; ;48 6*;8(*8; 45) 8¶8( †‡*8 6) );53*5;8 ;48 96*†, 5*† †?00 ;48 )‡?0. 5*† 6 ;46*7 6;’) 52‡?; ;698 ]8 );‡..8† (80:6*3 ‡* 6;.\n"

cipher_unique = unique_list [] cipher
frequency = [(x, 0) | x <- cipher_unique]

inc_frequency_tuple :: (Eq a) => (a, Integer) -> a -> (a, Integer)
inc_frequency_tuple lst ch = if (fst lst) == ch then (fst lst, (snd lst) + 1) else lst

inc_frequency_char :: (Eq a) => [(a, Integer)] -> a -> [(a, Integer)]
inc_frequency_char lst ch = [inc_frequency_tuple x ch | x <- lst]

inc_frequency :: (Eq a) => [(a, Integer)] -> [a] -> [(a, Integer)]
inc_frequency lst [] = lst
inc_frequency lst str = inc_frequency (inc_frequency_char lst (str !! 0)) (tail str)

frequency_list = inc_frequency frequency cipher

replace_list = [(fst x, fst x) | x <- frequency_list]

replace_char :: (Eq a) => (a,a) -> [a] -> [a] -> (a,a)
replace_char tup [] [] = tup
replace_char tup ch_torep ch_repwith = if (fst tup) == (ch_torep !! 0) then (fst tup, ch_repwith !! 0) else (replace_char tup (tail ch_torep) (tail ch_repwith))

replace_char_list :: (Eq a) => [(a,a)] -> [a] -> [a] -> [(a,a)]
replace_char_list lst ch_torep ch_repwith = [replace_char (lst !! y) ch_torep ch_repwith | y <- [0..(length(lst)-1)]]

replaced_list = replace_char_list replace_list ".:$9102-?]37()58;4*6\8224\8217\8225\182\162\8211" "pyqmflbcuwgkrsaethnid'ovx;"

return_tuple :: [(Char, Char)] -> Char -> (Char,Char)
return_tuple key ch = if (fst (key !! 0)) == ch then (key !! 0) else return_tuple (tail key) ch

replacer :: [(Char, Char)] -> Char -> Char -> Char
replacer key ch test = if (ch == '.' && (test == ' ' || test == '\n')) then '.' else snd (return_tuple key ch)

decipher :: [Char] -> [(Char, Char)] -> [Char]
decipher ciphertext key = [replacer key (ciphertext !! x) (ciphertext !! (x+1)) | x <- [0..(length(ciphertext)-2)]]


lowercase_converter :: [Char] -> [Char]
lowercase_converter message_input = [toLower x | x <- message_input]
char_replacer str = [if (x == '.' || x == ',' || x== ';' || x=='(' || x==')' || x==':') then ' ' else x | x <- str]

message = decipher cipher replaced_list
process_message = char_replacer (lowercase_converter message)
words_present = splitOn " " process_message

found message_input = [ x `elem` dictionary | x <- message_input]

correct_words [] = 0
correct_words words_found = if ((head words_found) == True) then (1 + (correct_words (tail words_found))) else (correct_words (tail words_found))

num_correct_words = correct_words (found words_present)
total_words = length(found words_present)

new_cipher=" Cge jlj cga plfj cgak exc qxti lfsg paftslgfxm okgykxhhlfy kdndxktb?\n\n Sge Z bxj x ugq xn x mdtsakdk xfj hc qgnn, hc Cdxj gp Xdoxkshdfs nxlj sg hd, \"Pdmm Wlhgf, Z'mm ylzd cga x mlybs sdxtblfy mgxj ng cga txf yds cgak kdndxktb nsxksdj.\" Eas gp tgaknd Z bxj fgs qddf x GbX nsajdfs ng Z bxj fg ljdx bge sg jg kdndxktb. Z egamj nls sbdkd lf hc gppltd elsb x qmxfi nbdds gp oxodk xfj x nbxko odftlm xfj exls pgk ykdxs ljdxn sg tghd. Mp tgaknd, fgsblfy jlj. Rbdf xf afjdkykxjaxsd egamj ifgti xs sbd jggk xfj nxc, \"Wlhgf, jg cga bxzd x hghdfs?\" Z'j edmtghd sbdh lf xn x jlnskxtslgf pkgh sbln jlppltams qanlfdnn gp jglfy kdndxktb.\n\nQzdfsaxmmc gfd gp hc tgmmdxyadn, x kdxmmc yggj yac, txmmdj Tgbf Pxnbqkggi, nxlj sg hd, \"Wlhgf, cga nbgamj uans yds gf xfj jg nghdsblfy fg hxssdk bge bahqmd xfj nlhomd.\" Zf sbd dfj sbd plkns sblfy sbxs Z jlj exn Z ekgsd x oxkndk ydfdkxsgk pgk x paftslgfxm mxfyaxyd WKWN, ng ls exn x qls mlid Dxtt. Z txmmdj ls “Dxtt lf WKWN.” Rbxs ygs oaqmlnbdj lf 1985 lf Wgpsexkd Gkxtsltd xfj Qwodkldftd.\n\nKs sbd slhd, Z exn zdkc lfnolkdj qc Xxzlj Rakfdk'n oxodkn xqgas WH tghqlfxsgkn. Z exn lf Ngfjgf, bd exn lf Bxfsdkqakc, ng Z xnidj blh sg qd xf lfpgkhxm hdfsgk. Wlftd Z jljf's bxzd xf xjzlndk bd exn hc ngks gp kdhgsd xjzlngk. Z egamj yg sg ndd blh dzdkc pde hgfsbn xfj ed egamj bxzd x tbxs gzdk tgppdd. Rbxs exn lftkdjlqmc bdmopam sg hd qdtxand Z jlj pddm x qls aftdksxlf xqgas ebxs sg jg.\n Cge jlj cga jdtljd sbxs paftslgfxm okgykxhhlfy exn ebxs cga exfsdj sg jg kdndxktb gf?\n\n Rbxs exn xs Bxhqkljyd eblmd Z exn ydsslfy hc Xlomghx. Rbdkd exn x zdkc dttdfsklt okgpdnngk sbdkd txmmdj Kksbak Sgkhxf xfj bd exn qly gf tghoasdk xmydqkx xs sbd slhd. Cd yxzd x nbgks ndkldn gp mdtsakdn xqgas paftslgfxm okgykxhhlfy, ebltb Z bxj fdzdk bdxkj gp, lf ebltb bd nbgedj nghd paftslgfxm okgykxhn. Cd dzdf qalms sblfyn mlid tlktamxk mlnsn, ebltb jljf's nddh dzdf ognnlqmd ylzdf cga jgf's bxzd xfc nljd dppdtsn. Rbd ndtgfj sblfy exn Xxzlj Rakfdk'n oxodkn xqgas WH tghqlfxsgkn xfj sbd xhxvlfy ljdx sbxs cga tgamj sxid mxhqjx dwokdnnlgfn xfj skxfnmxsd sbdh lfsg sbln qly hdnn gp W'n xfj H'n xfj ls egamj dzxmaxsd sg sbd nxhd sblfy.\n\nKfj xmm gp sbxs gttakkdj xs sbd nxhd slhd sbxs Tgbf Extian exn elfflfy sbd Raklfy Kexkj xfj ylzlfy bln sxmi txmmdj “Bxf Gkgykxhhlfy Ed Nlqdkxsdj Ukgh sbd zgf Sdahxff Wscmd?\" Zf bln sxmi bd lfskgjatdj UG, bln paftslgfxm okgykxhhlfy mxfyaxyd, xfj txns ls lf x qly oltsakd. Cd nxlj, \"Rbln ln sbd exc sg eklsd okgykxhn, xfj hgkdgzdk fgs gfmc elmm ls kdzgmaslgflvd okgykxhhlfy qas ed nbgamj dzdf qalmj fde tghoasdkn sg dwdtasd sbdnd okgykxhn.\" Rbln exn x txmm sg xtslgf. Pd xmkdxjc sbgaybs paftslgfxm okgykxhhlfy exn tggm, qas bdkd exn sbln dwskdhdmc pxhgan yac nxclfy \"Zs'n fgs gfmc tggm ls'n sbd Ylybs Rblfy sg jg.\" Rbdkd edkd x qaftb gp odgomd xs Bxhqkljyd, Tgbf Caybdn, Rbghxn Bmxkid, Tgf Uxlkqxlkf, hcndmp, xfj x pde gsbdkn ebg xmm ygs dwtlsdj xqgas paftslgfxm okgykxhhlfy xs sbd nxhd slhd. Zs exn gfd gp sbgnd tglftljdfsxm sblfyn. Pd xmm uans txaybs plkd.\n\n Pbxs edkd sbd qly godf okgqmdhn lf paftslgfxm okgykxhhlfy ebdf cga edkd ydsslfy lfsg ls?\n\n Uaftslgfxm okgykxhhlfy ln x kxjltxm xfj dmdyxfs xssxti gf sbd ebgmd dfsdkoklnd gp eklslfy okgykxhn. Zs'n zdkc jlppdkdfs pkgh sbd \"jg sbln xfj sbdf jg sbxs” okgykxhhlfy hdfsxmlsc. Dga bxzd sg kdelkd cgak qkxlf lf ralsd x jlppdkdfs exc. Ugk x mgfy slhd ls exn edmm afjdknsggj sbdgkdsltxmmc—sbdkd exn mgsn gp nsapp xqgas ndhxfsltn xfj ls bxj sbdnd zdkc jddo pgafjxslgfn lf mgylt. Eas lf sdkhn gp x okxtsltxm okgykxhhlfy hdjlah ls nddhdj mlid x tghomdsdmc zlkylf pldmj. Rbdf elsb Xxzlj Rakfdk’n egki, xfj elsb sbd ebgmd LN dppgks xs Qjlfqakyb, odgomd najjdfmc nsxksdj sg nxc, \"Ktsaxmmc, sbdnd mxfyaxydn tgamj qd fgs uans dmdyxfs, xfj qdxaslpam, xfj hxsbdhxsltxmmc tggm—qas xmng andpam. Dga hlybs xtsaxmmc qd xqmd sg eklsd lfsdkdnslfy okgykxhn anlfy sbdh.\" Rbxs exn sbd hgzdhdfs sbxs Z ygs lfzgmzdj lf.\n\n Z exfsdj sg sxmi xqgas bge Cxnidmm txhd xqgas.\n\n Zf sbd mxsd 80'n sbdkd edkd x fahqdk gp ndoxkxsd kdndxktbdkn ebg edkd jglfy nsapp elsb mxvc paftslgfxm okgykxhhlfy. Z exn gfd, Tgbf Caybdn exn xfgsbdk, Gxam Cajxi exn xfgsbdk, Rbghxn Tgbfnngf xfj Ndffxks Kayansnngf xs Vgsbdfqaky, Kkzlfj xfj bln jxsxpmge tgmmdxyadn xs LZR, Tgd Uxndm Ngn Kmxhgn exn xfgsbdk, Ylfan Gmxnhdludk xs Sluhdydf, xfj ng gf. Rbdkd edkd hxcqd x jgvdf xmm sgydsbdk.\n\nPd egamj hdds dxtb gsbdk xs tgfpdkdftdn xfj ed txhd sg kdxmlvd sbxs ed edkd xmm qalmjlfy mlssmd okgykxhhlfy mxfyaxydn xfj sbdc xmm qxnltxmmc mggidj sbd nxhd. Pd sbgaybs, \"Mb, ed nbgamj jg nghdsblfy zdkc hgjdns, zdkc bahqmd. Pd nbgamj uans xykdd x tghhgf ncfsxw ng sbxs ed txf kaf dxtb gsbdk'n okgykxhn.\" Pd bxj WKWN xfj Llkxfjx, Xxzlj Rakfdk'n mxfyaxydn pgk yaljxftd, ng ed sbgaybs ed'mm uans tgbdkd xkgafj nghd ncfsxtslt mdxns tghhgf jdfghlfxsgk. Pd exfsdj x qxnln pgk sdxtblfy xfj kdndxktb uans sg xzglj affdtdnnxkc jlzdknlsc. Pd edkdf's sblfilfy gp Cxnidmm xn x exc sg ngmzd kdndxktb okgqmdhn xs xmm, hgkd xn x naqnskxsd pgk kdndxktb.\n\nPd hds xfj jdtljdj, \"Pd nbgamj pgkh x tghhlssdd xfj jdnlyf x mxfyaxyd.\" Wg ed jlj, xfj ed sbdf obcnltxmmc hds lf odkngf. Rbln exnf's qdpgkd dhxlm, qas ls exn tdksxlfmc qdpgkd sbd edq xfj tgmmxqgkxslzd egkilfy xfj ng-pgksb. Pd obcnltxmmc hds gf ndzdkxm gttxnlgfn sg jdnlyf sbd mxfyaxyd. Rbd nakoklnlfy sblfy ln sbxs ls sakfdj lfsg x kdndxktb okgudts.\n Cge jlj sbxs tghd xqgas?\n\nWdzdkxm sblfyn sbxs bxoodfdj sbxs edkd ralsd ndkdfjlolsgan xfj afdwodtsdj. Pd ifde ls exn yglfy sg qd mxvc, ed ifde ls exn yglfy sg bxzd oxkxhdsklt ogmchgkoblnh mlid LN jgdn, xfj ed ifde ls egamj bxzd xmydqkxlt jxsx scodn xfj oxssdkf hxstblfy. Rbxs exn xmm oxks gp sbd tgfndfnan gp ebxs ed edkd nsxkslfy pkgh. Rcod tmxnndn, gf sbd gsbdk bxfj, edkd dfslkdmc fde.\nPd bxj nodfs nghd slhd jdqxslfy ebxs ed edkd yglfy sg jg xqgas paftslgfn mlid kdxj, nbge, ndklxmlvxslgf, xfj draxmlsc. Rbdc'kd fgs oxkxhdskltxmmc ogmchgkoblt, qas sbdc xkd x qls ogmchgkoblt, qdtxand sbdc nbgamj egki gf x mgs gp scodn. Kfj sbdf, gas gp sbd qmad, Gblm Pxjmdk xfj bln nsajdfs Wsdzd Emgss okgjatdj, pammc pgkhdj, sbd ljdx gp scod tmxnndn. Z nslmm bxzd sbd dhxlm ebltb bd ndfs: ls exn xmhgns mlid x mlssmd oxodk sg sbd sbdf tghhlssdd. Pd edkd qgemdj gzdk: \"Mb, sbln ln bge ed tgamj jdxm elsb xmm gp sbgnd xeiexkj okgqmdhn.\" Ks sbxs nsxyd, ed bxj x tbgltd hxid. Pd tgamj iddo sblfilfy gp Cxnidmm dhqgjclfy x takkdfs tgfndfnan, xn ed bxj qddf. Eas ed jljf’s jg sbxs. Zfnsdxj ed nxlj, \"Rcod tmxnndn hxc qd fde, qas sbdc ngmzd x kdxmmc fxnsc, xeiexkj okgqmdh sbxs'n x exks gf sbd pxtd gp gak qdxaslpam mxfyaxyd. Nds’n dhqkxtd sbdh.\" Wg ed lftgkogkxsdj scod tmxnndn ebgmdbdxksdjmc, xfj sbdc sakfdj gas sg qd gfd gp Cxnidmm'n qly tgfsklqaslgfn sg sbd egkmj.\n\nUgk kdxngfn mlid sbln—hgfxjlt Z/M ln xfgsbdk dwxhomd—Cxnidmm dfjdj ao qdlfy nlyflpltxfsmc hgkd lffgzxslzd xfj xhqlslgan sbxs ed bxj gklylfxmmc lfsdfjdj. Eas sbxs exn mxkydmc xttljdfsxm.\n\n Pbxs exn sbd qlyydns nakoklnd xqgas oasslfy Cxnidmm gas sbdkd?\n\n Z bxj xmexcn xnnahdj sbxs sbd hgkd qmddjlfy djyd tbxfydn sg sbd scod ncnsdh, sblfyn mlid scod-mdzdm paftslgfn, ydfdkxmlvdj xmydqkxlt jxsx scodn (VKXRn), blybdk kxfi ogmchgkoblnh, xfj dwlnsdfslxm jxsx scodn, egamj qd oltidj ao xfj andj dfsbanlxnsltxmmc qc GbX nsajdfsn lf ndxktb gp x sgolt, qas fgs kdxmmc andj hatb lf lfjanskc. Eas lf pxts ls sakfn gas sbxs odgomd lf tghoxfldn xkd anlfy nghd gp sbdnd nslmm-fgs-sdkklqmc-nsxqmd dwsdfnlgfn. Z sblfi ls'n qdtxand odgomd lf tghoxfldn xkd eklslfy ngpsexkd sbxs sbdc exfs sg nslmm qd xqmd sg hxlfsxlf xfj hgjlpc lf plzd cdxkn slhd. Kn cga ntxmd ao, xfj xn cgak xhqlslgf xqgas slhdntxmd lftkdxndn, ng hxcqd cga'mm lfzdns hgkd lf sbd nsxslt yaxkxfsddn cga yds pkgh x scod ncnsdh, xfj sbdf cga oanb sbd scod ncnsdh bxkjdk. Dga ndd odgomd gas lf lfjanskc eklslfy qmgy ognsn xqgas txsxhgkoblnhn xfj txsdygkltxm tgffdtslgfn, xfj omdfsc gp nsapp sbxs Z jgf's afjdknsxfj. Wghdbge, sbd mdzdm gp xqnskxtslgf gppdkdj qc x ngoblnsltxsdj scod ncnsdh mdsn cga yds hatb hgkd xhqlslgan lf sdkhn gp sbd lfsdmmdtsaxm tghomdwlsc gp ebxs cga txf jdxm elsb.\n\n Kn cga edkd jglfy xmm gp sbln egki, ebxs exn sbd kdmxslgfnblo gp sbd paftslgfxm okgykxhhlfy egki sg ebxs gsbdk odgomd edkd lfsdkdnsdj lf xs GMGN xs sbd slhd?\n\n Zflslxmmc Z xmexcn sbgaybs gp GMGN xn qdlfy x tgfpdkdftd sbxs exn pgk odgomd tmdzdkdk sbxf hd, ng ls exn ralsd x eblmd qdpgkd Z dzdf naqhlssdj x oxodk sg GMGN. Eas ebdf Z jlj Z pgafj x tghhaflsc sbxs exn tghomdsdmc xmlyfdj elsb sbd ilfj gp sblfyn sbxs Z txkdj xqgas. Zs'n klybs sbdkd lf sbd slsmd lnf's ls? Gklftlomdn gp Gkgykxhhlfy Nxfyaxydn, ng ls txkdn xqgas qdlfy oklftlomdj xfj ls txkdn xqgas dmdyxftd xfj dtgfghc gp dppgks. Rkc sg yds sbd ugq jgfd elsb xn mlssmd hxtblfdkc xn ognnlqmd. Zfjddj, Z pddm sbxs hgns gp hc kdndxktb mlpd ln xqgas nxclfy, \"Zs bxn sg qd nlhomdk.\"\n\nZ xmexcn pdms Z exn hgkd gp x sbdgkc andk, fgs x sbdgkc jdzdmgodk, ebdkdxn Z'h x tgholmdk jdzdmgodk, fgs uans x tgholmdk andk. Wg Z xmexcn pdms nmlybsmc gas gp hc tmxnn xs GMGN. Z nslmm jg.\n\n Pbxs ln xf lhogksxfs okgqmdh gak tghhaflsc txf egki gf ngmzlfy lf sbd fdws plzd gk sdf cdxkn?\n\n Qjatxslgf. Zp ed'kd sg yds sbd oklftlomdn, xfj dmdyxftd, xfj hgjamxklsc, xfj dtgfghc gp dppgks, xfj xqnskxtslgfn sbxs GMGN tgfsklqasgkn zxmad ng blybmc, lp ed xkd sg yds sbdh xtsaxmmc oxks gp sbd pxqklt gp sbd ngpsexkd sbxs bgmjn gak jlylsxm mlzdn sgydsbdk, sbd exc sg jg sbxs ln qc lfnslmmlfy sbgnd zxmadn lfsg gak afjdkykxjaxsdn, xfj ng sbdf sbdc elmm qdtghd sbd jdzdmgodkn gp sbd pasakd, xfj BRM'n gp nsxksaon. Wg, sbdkd'n x qly lfdkslx sg gzdktghd, qas gzdk slhd ls'mm bxoodf. Kn Z gpsdf nxc, ebdf sbd mlhdnsgfd gp lhodkxslzd okgykxhhlfy bxn egkf xexc, sbd ykxflsd gp paftslgfxm okgykxhhlfy elmm qd kdzdxmdj afjdkfdxsb."

new_cipher_unique = unique_list [] new_cipher

new_frequency = [(x, 0) | x <- new_cipher_unique]
new_frequency_list = inc_frequency new_frequency new_cipher

new_replace_list = [(fst x, fst x) | x <- new_frequency_list]
new_replaced_list = replace_char_list new_replace_list "sbdxgfmnkplayocjzhqteuZiCSXPWEGMQwRTKNDHBvUYrLV" "theaonlsrfiugpydvmbcwjIkHNDWSBPOExTJALYKCzFRqMG"

new_message = decipher new_cipher new_replaced_list
new_process_message = char_replacer (lowercase_converter new_message)
new_words_present = splitOn " " new_process_message

new_num_correct_words = correct_words (found new_words_present)
new_total_words = length(found new_words_present)

printstr str len = if ((length str) == len) then putStr (str ++ "\n") else putStr ""
print_words text len = [x | x <- (splitOn " " text), length(x)==len]

cipher_words_unique text len = unique_list [] (print_words text len)
words_frequency text len = [(x, 0) | x <- (cipher_words_unique text len)]

words_frequency_list text len = inc_frequency (words_frequency text len) (print_words text len)