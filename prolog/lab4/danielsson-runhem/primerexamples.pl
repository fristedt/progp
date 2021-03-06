% Example 1: Every gene has unique primers. A one-genome case, really.
%            Three primers necessary.
ex1(6, [pri(a, [1,2]), pri(b, [3,4]), pri(c, [5,6])]).

% Example 2: Two identical genomes, same primer for corresponding genes.
%            Three primers necessary.
ex2(6, [pri(a1, [1,2]), pri(b1, [3,4]), pri(c1, [5,6]),
	pri(a2, [1,2]), pri(b2, [3,4]), pri(c2, [5,6])]).

% Example 3: Two identical genomes, different primers for corresponding genes.
%            Three primers necessary.
ex3(6, [pri(a1, [1,2]), pri(b1, [3,4]), pri(c1, [5,6]),
	pri(a2, [3,5]), pri(b2, [2,6]), pri(c2, [1,4])]).

% Example 4: Three genomes. The new genome share one primer for each
%            gene and has an alternative as well. Four primers
%            seem necessary.
ex4(9, [pri(a1, [1,2]), pri(b1, [3,4]), pri(c1, [5,6]),
	pri(a2, [3,5]), pri(b2, [2,6]), pri(c2, [1,4]),
	pri(a3, [1,7]), pri(b3, [2,8]), pri(c3, [4,9])]).

% Example 5: Five genomes. This is basically example four but
%            with a copy of genome 1 added. The same four
%            might be a good solution.
ex5(9, [pri(a1, [1,2]), pri(b1, [3,4]), pri(c1, [5,6]),
	pri(a2, [3,5]), pri(b2, [2,6]), pri(c2, [1,4]),
	pri(a3, [1,7]), pri(b3, [2,8]), pri(c3, [4,9]),
	pri(a4, [1,2]), pri(b4, [3,4]), pri(c4, [5,6])]).

% Example 6: Three genomes. A greedy solution would choose primer 1
%            since it is usable for genes a1, a2, and a3. However,
%            that would require unique primers for genes b1, b2, and b3.
%            If we instead discard primer 1 and use primers 2, 3, and 4,
%            these can be re-used in the other genes.
ex6(7, [pri(a1, [1,2]), pri(b1, [3]), pri(c1, [5,6]),
	pri(a2, [1,3]), pri(b2, [4]), pri(c2, [7,5]),
	pri(a3, [1,4]), pri(b3, [2]), pri(c3, [6,7])]).

% Example 7: Randomly generated over four genomes.
ex7(15, [pri(s0g0, [11, 9, 10, 6, 7]),
	 pri(s0g1, [3, 12, 8, 15, 2]),
	 pri(s1g0, [3, 2, 13, 6, 10]),
	 pri(s1g1, [8, 12, 11, 7, 15]),
	 pri(s2g0, [2, 5, 13, 8, 15]),
	 pri(s2g1, [4, 3, 12, 6, 10]),
	 pri(s3g0, [12, 13, 1, 4, 9]),
	 pri(s3g1, [3, 6, 14, 11, 7]),
	 pri(s4g0, [4, 8, 9, 5, 12]),
	 pri(s4g1, [13, 10, 1, 6, 14])]).


% Example 8: Randomly generated over two genomes. 
ex8(43, [pri(s0g0, [1, 2, 3, 4]),
	 pri(s0g1, [5, 6, 7, 8]),
	 pri(s0g2, [9, 10, 11, 12, 13]),
	 pri(s0g3, [14, 15]),
	 pri(s0g4, [16]),
	 pri(s0g5, [17]),
	 pri(s0g6, [18, 19, 20, 21]),
	 pri(s0g7, [22, 23, 24]),
	 pri(s0g8, [25]),
	 pri(s0g9, [26, 27]),
	 pri(s1g0, [28, 10]),
	 pri(s1g1, [23]),
	 pri(s1g2, [24]),
	 pri(s1g3, [21, 29, 8, 30]),
	 pri(s1g4, [27, 9, 31, 32, 33]),
	 pri(s1g5, [34, 35]),
	 pri(s1g6, [36, 13]),
	 pri(s1g7, [37, 38, 39, 40, 41]),
	 pri(s1g8, [42]),
	 pri(s1g9, [43])]).

ex9(54, [pri(s0g0, [1, 2]),
pri(s0g1, [3, 4]),
pri(s0g2, [5]),
pri(s0g3, [6, 7]),
pri(s0g4, [8]),
pri(s0g5, [9]),
pri(s0g6, [10]),
pri(s0g7, [11]),
pri(s0g8, [12, 13, 14]),
pri(s0g9, [15, 16]),
pri(s0g10, [17]),
pri(s0g11, [18, 19]),
pri(s0g12, [20, 21, 22]),
pri(s0g13, [23]),
pri(s0g14, [24, 25]),
pri(s0g15, [26]),
pri(s0g16, [27]),
pri(s0g17, [28, 29]),
pri(s0g18, [30, 31, 32]),
pri(s0g19, [33]),
pri(s1g0, [34]),
pri(s1g1, [6, 10, 3]),
pri(s1g2, [35, 36, 37]),
pri(s1g3, [38, 4]),
pri(s1g4, [21, 39, 29]),
pri(s1g5, [5]),
pri(s1g6, [40]),
pri(s1g7, [16]),
pri(s1g8, [41]),
pri(s1g9, [42, 15, 25]),
pri(s1g10, [43]),
pri(s1g11, [44]),
pri(s1g12, [45, 33]),
pri(s1g13, [46]),
pri(s1g14, [47, 48]),
pri(s1g15, [49, 19, 2]),
pri(s1g16, [50, 51, 9]),
pri(s1g17, [13, 32, 8]),
pri(s1g18, [52, 18, 53]),
pri(s1g19, [20, 54])]).


% Example 10: Randomly generated over two genomes.
ex10(133, [pri(s0g0, [1]),
pri(s0g1, [2]),
pri(s0g2, [3, 4]),
pri(s0g3, [5]),
pri(s0g4, [6]),
pri(s0g5, [7, 8]),
pri(s0g6, [9, 10]),
pri(s0g7, [11, 12, 13]),
pri(s0g8, [14, 15]),
pri(s0g9, [16]),
pri(s0g10, [17, 18]),
pri(s0g11, [19]),
pri(s0g12, [20, 21]),
pri(s0g13, [22, 23, 24]),
pri(s0g14, [25, 26, 27]),
pri(s0g15, [28]),
pri(s0g16, [29, 30, 31]),
pri(s0g17, [32]),
pri(s0g18, [33, 34]),
pri(s0g19, [35]),
pri(s0g20, [36, 37]),
pri(s0g21, [38, 39, 40]),
pri(s0g22, [41, 42, 43]),
pri(s0g23, [44, 45]),
pri(s0g24, [46, 47]),
pri(s0g25, [48]),
pri(s0g26, [49]),
pri(s0g27, [50, 51, 52]),
pri(s0g28, [53, 54]),
pri(s0g29, [55]),
pri(s0g30, [56]),
pri(s0g31, [57]),
pri(s0g32, [58, 59]),
pri(s0g33, [60]),
pri(s0g34, [61]),
pri(s0g35, [62]),
pri(s0g36, [63, 64]),
pri(s0g37, [65, 66, 67]),
pri(s0g38, [68]),
pri(s0g39, [69, 70]),
pri(s0g40, [71, 72]),
pri(s0g41, [73, 74, 75]),
pri(s0g42, [76, 77, 78]),
pri(s0g43, [79, 80]),
pri(s0g44, [81, 82]),
pri(s0g45, [83, 84]),
pri(s0g46, [85]),
pri(s0g47, [86, 87]),
pri(s0g48, [88]),
pri(s0g49, [89, 90, 91]),
pri(s1g0, [92, 93, 75]),
pri(s1g1, [94, 95, 15]),
pri(s1g2, [96]),
pri(s1g3, [97, 98, 99]),
pri(s1g4, [100]),
pri(s1g5, [61, 58, 59]),
pri(s1g6, [50]),
pri(s1g7, [32, 37, 69]),
pri(s1g8, [101, 63, 73]),
pri(s1g9, [27]),
pri(s1g10, [60, 102]),
pri(s1g11, [103]),
pri(s1g12, [30, 46]),
pri(s1g13, [104]),
pri(s1g14, [105]),
pri(s1g15, [106]),
pri(s1g16, [107, 108, 109]),
pri(s1g17, [110]),
pri(s1g18, [41]),
pri(s1g19, [19]),
pri(s1g20, [111, 84, 112]),
pri(s1g21, [77, 43, 8]),
pri(s1g22, [33]),
pri(s1g23, [113, 114, 115]),
pri(s1g24, [76, 17, 116]),
pri(s1g25, [14]),
pri(s1g26, [117, 56]),
pri(s1g27, [54]),
pri(s1g28, [7]),
pri(s1g29, [118, 119, 20]),
pri(s1g30, [120]),
pri(s1g31, [10, 81]),
pri(s1g32, [121, 122, 65]),
pri(s1g33, [47]),
pri(s1g34, [123]),
pri(s1g35, [34]),
pri(s1g36, [124, 55]),
pri(s1g37, [25]),
pri(s1g38, [64]),
pri(s1g39, [125]),
pri(s1g40, [21, 78, 16]),
pri(s1g41, [53, 48]),
pri(s1g42, [40, 126]),
pri(s1g43, [127, 128, 12]),
pri(s1g44, [80]),
pri(s1g45, [22]),
pri(s1g46, [129, 28, 130]),
pri(s1g47, [38, 89, 90]),
pri(s1g48, [131, 132, 133]),
pri(s1g49, [86])]).

% Example 11: Randomly generated over two genomes.
ex11(291, [pri(s0g0, [1, 2, 3]),
pri(s0g1, [4, 5]),
pri(s0g2, [6, 7, 8]),
pri(s0g3, [9, 10]),
pri(s0g4, [11]),
pri(s0g5, [12, 13]),
pri(s0g6, [14]),
pri(s0g7, [15]),
pri(s0g8, [16, 17]),
pri(s0g9, [18]),
pri(s0g10, [19, 20, 21]),
pri(s0g11, [22, 23, 24]),
pri(s0g12, [25, 26]),
pri(s0g13, [27, 28]),
pri(s0g14, [29, 30]),
pri(s0g15, [31]),
pri(s0g16, [32, 33, 34]),
pri(s0g17, [35, 36, 37]),
pri(s0g18, [38]),
pri(s0g19, [39, 40, 41]),
pri(s0g20, [42, 43]),
pri(s0g21, [44, 45, 46]),
pri(s0g22, [47]),
pri(s0g23, [48]),
pri(s0g24, [49, 50]),
pri(s0g25, [51, 52, 53]),
pri(s0g26, [54, 55, 56]),
pri(s0g27, [57, 58, 59]),
pri(s0g28, [60]),
pri(s0g29, [61]),
pri(s0g30, [62, 63]),
pri(s0g31, [64]),
pri(s0g32, [65]),
pri(s0g33, [66, 67, 68]),
pri(s0g34, [69, 70]),
pri(s0g35, [71]),
pri(s0g36, [72, 73]),
pri(s0g37, [74, 75]),
pri(s0g38, [76, 77]),
pri(s0g39, [78, 79]),
pri(s0g40, [80, 81]),
pri(s0g41, [82]),
pri(s0g42, [83]),
pri(s0g43, [84]),
pri(s0g44, [85, 86, 87]),
pri(s0g45, [88]),
pri(s0g46, [89]),
pri(s0g47, [90]),
pri(s0g48, [91, 92, 93]),
pri(s0g49, [94, 95, 96]),
pri(s0g50, [97, 98, 99]),
pri(s0g51, [100, 101, 102]),
pri(s0g52, [103, 104]),
pri(s0g53, [105, 106, 107]),
pri(s0g54, [108, 109, 110]),
pri(s0g55, [111]),
pri(s0g56, [112, 113, 114]),
pri(s0g57, [115]),
pri(s0g58, [116]),
pri(s0g59, [117]),
pri(s0g60, [118, 119]),
pri(s0g61, [120, 121, 122]),
pri(s0g62, [123, 124]),
pri(s0g63, [125, 126]),
pri(s0g64, [127, 128, 129]),
pri(s0g65, [130, 131, 132]),
pri(s0g66, [133, 134]),
pri(s0g67, [135]),
pri(s0g68, [136, 137]),
pri(s0g69, [138, 139]),
pri(s0g70, [140, 141]),
pri(s0g71, [142, 143, 144]),
pri(s0g72, [145]),
pri(s0g73, [146, 147]),
pri(s0g74, [148, 149]),
pri(s0g75, [150]),
pri(s0g76, [151, 152]),
pri(s0g77, [153, 154]),
pri(s0g78, [155]),
pri(s0g79, [156, 157, 158]),
pri(s0g80, [159, 160, 161]),
pri(s0g81, [162]),
pri(s0g82, [163]),
pri(s0g83, [164]),
pri(s0g84, [165]),
pri(s0g85, [166, 167, 168]),
pri(s0g86, [169]),
pri(s0g87, [170]),
pri(s0g88, [171, 172, 173]),
pri(s0g89, [174]),
pri(s0g90, [175, 176, 177]),
pri(s0g91, [178, 179]),
pri(s0g92, [180]),
pri(s0g93, [181, 182]),
pri(s0g94, [183, 184]),
pri(s0g95, [185]),
pri(s0g96, [186, 187, 188]),
pri(s0g97, [189]),
pri(s0g98, [190]),
pri(s0g99, [191, 192]),
pri(s1g0, [193, 194, 12]),
pri(s1g1, [195, 90]),
pri(s1g2, [126, 196]),
pri(s1g3, [82, 197, 108]),
pri(s1g4, [13, 136]),
pri(s1g5, [198, 65, 199]),
pri(s1g6, [200]),
pri(s1g7, [37, 36]),
pri(s1g8, [88, 121, 201]),
pri(s1g9, [202, 203, 76]),
pri(s1g10, [159, 7, 204]),
pri(s1g11, [38, 119]),
pri(s1g12, [205]),
pri(s1g13, [206, 30]),
pri(s1g14, [70, 207, 80]),
pri(s1g15, [138, 64]),
pri(s1g16, [208]),
pri(s1g17, [209]),
pri(s1g18, [210, 97, 52]),
pri(s1g19, [145]),
pri(s1g20, [69, 62, 21]),
pri(s1g21, [211]),
pri(s1g22, [212, 61, 34]),
pri(s1g23, [115, 213, 214]),
pri(s1g24, [215, 216, 217]),
pri(s1g25, [15, 218, 219]),
pri(s1g26, [110, 220, 165]),
pri(s1g27, [89]),
pri(s1g28, [221, 177, 222]),
pri(s1g29, [47]),
pri(s1g30, [223, 173]),
pri(s1g31, [123, 224]),
pri(s1g32, [133, 225, 226]),
pri(s1g33, [227, 228]),
pri(s1g34, [229]),
pri(s1g35, [230]),
pri(s1g36, [151, 1]),
pri(s1g37, [231, 232]),
pri(s1g38, [166, 233, 6]),
pri(s1g39, [187]),
pri(s1g40, [234]),
pri(s1g41, [235, 57]),
pri(s1g42, [236, 104, 155]),
pri(s1g43, [237, 141, 238]),
pri(s1g44, [23, 31]),
pri(s1g45, [239, 240, 172]),
pri(s1g46, [105]),
pri(s1g47, [60, 99, 116]),
pri(s1g48, [241]),
pri(s1g49, [154, 242]),
pri(s1g50, [114, 243, 18]),
pri(s1g51, [87]),
pri(s1g52, [94]),
pri(s1g53, [127, 244, 245]),
pri(s1g54, [246, 247]),
pri(s1g55, [189]),
pri(s1g56, [113, 147]),
pri(s1g57, [248, 249, 43]),
pri(s1g58, [140]),
pri(s1g59, [250]),
pri(s1g60, [251]),
pri(s1g61, [252]),
pri(s1g62, [253, 11, 72]),
pri(s1g63, [96, 254, 153]),
pri(s1g64, [24, 255]),
pri(s1g65, [17, 134, 85]),
pri(s1g66, [183]),
pri(s1g67, [256]),
pri(s1g68, [257, 258]),
pri(s1g69, [259, 25]),
pri(s1g70, [260]),
pri(s1g71, [53]),
pri(s1g72, [261, 262]),
pri(s1g73, [263, 170]),
pri(s1g74, [146, 264]),
pri(s1g75, [265, 92]),
pri(s1g76, [157, 266, 267]),
pri(s1g77, [268]),
pri(s1g78, [269]),
pri(s1g79, [270, 271, 63]),
pri(s1g80, [135, 272]),
pri(s1g81, [273]),
pri(s1g82, [19, 49]),
pri(s1g83, [139, 274]),
pri(s1g84, [275]),
pri(s1g85, [83, 27]),
pri(s1g86, [276, 277, 22]),
pri(s1g87, [68, 188]),
pri(s1g88, [39, 278]),
pri(s1g89, [279, 280]),
pri(s1g90, [144]),
pri(s1g91, [281]),
pri(s1g92, [282, 283]),
pri(s1g93, [284, 158]),
pri(s1g94, [285, 286]),
pri(s1g95, [73, 287, 167]),
pri(s1g96, [288, 289]),
pri(s1g97, [122, 171, 101]),
pri(s1g98, [290]),
pri(s1g99, [291])]).

% Example 12: Randomly generated over three genomes.
% Removed: GNU Prolog cannot read it! Lame.
ex12(330, [pri(s0g0, [1]),
pri(s0g1, [2, 3]),
pri(s0g2, [4]),
pri(s0g3, [5, 6, 7]),
pri(s0g4, [8, 9]),
pri(s0g5, [10, 11, 12]),
pri(s0g6, [13, 14, 15]),
pri(s0g7, [16, 17, 18]),
pri(s0g8, [19]),
pri(s0g9, [20]),
pri(s0g10, [21]),
pri(s0g11, [22]),
pri(s0g12, [23, 24]),
pri(s0g13, [25, 26, 27]),
pri(s0g14, [28, 29, 30]),
pri(s0g15, [31, 32, 33]),
pri(s0g16, [34, 35]),
pri(s0g17, [36]),
pri(s0g18, [37, 38, 39]),
pri(s0g19, [40, 41, 42]),
pri(s0g20, [43, 44]),
pri(s0g21, [45]),
pri(s0g22, [46]),
pri(s0g23, [47, 48]),
pri(s0g24, [49, 50, 51]),
pri(s0g25, [52, 53]),
pri(s0g26, [54, 55]),
pri(s0g27, [56]),
pri(s0g28, [57]),
pri(s0g29, [58]),
pri(s0g30, [59]),
pri(s0g31, [60]),
pri(s0g32, [61, 62]),
pri(s0g33, [63, 64, 65]),
pri(s0g34, [66, 67, 68]),
pri(s0g35, [69, 70, 71]),
pri(s0g36, [72]),
pri(s0g37, [73, 74, 75]),
pri(s0g38, [76, 77, 78]),
pri(s0g39, [79]),
pri(s0g40, [80]),
pri(s0g41, [81, 82, 83]),
pri(s0g42, [84, 85]),
pri(s0g43, [86]),
pri(s0g44, [87]),
pri(s0g45, [88, 89, 90]),
pri(s0g46, [91]),
pri(s0g47, [92]),
pri(s0g48, [93]),
pri(s0g49, [94]),
pri(s0g50, [95, 96, 97]),
pri(s0g51, [98, 99]),
pri(s0g52, [100, 101, 102]),
pri(s0g53, [103]),
pri(s0g54, [104, 105, 106]),
pri(s0g55, [107, 108, 109]),
pri(s0g56, [110, 111, 112]),
pri(s0g57, [113, 114]),
pri(s0g58, [115, 116, 117]),
pri(s0g59, [118, 119, 120]),
pri(s0g60, [121]),
pri(s0g61, [122, 123]),
pri(s0g62, [124]),
pri(s0g63, [125, 126, 127]),
pri(s0g64, [128, 129, 130]),
pri(s0g65, [131]),
pri(s0g66, [132, 133]),
pri(s0g67, [134]),
pri(s0g68, [135]),
pri(s0g69, [136, 137, 138]),
pri(s0g70, [139, 140]),
pri(s0g71, [141, 142]),
pri(s0g72, [143, 144]),
pri(s0g73, [145, 146, 147]),
pri(s0g74, [148, 149]),
pri(s0g75, [150, 151, 152]),
pri(s0g76, [153, 154, 155]),
pri(s0g77, [156, 157, 158]),
pri(s0g78, [159, 160, 161]),
pri(s0g79, [162]),
pri(s0g80, [163]),
pri(s0g81, [164, 165]),
pri(s0g82, [166, 167]),
pri(s0g83, [168]),
pri(s0g84, [169, 170]),
pri(s0g85, [171, 172]),
pri(s0g86, [173]),
pri(s0g87, [174, 175]),
pri(s0g88, [176, 177, 178]),
pri(s0g89, [179, 180, 181]),
pri(s0g90, [182, 183]),
pri(s0g91, [184, 185]),
pri(s0g92, [186, 187, 188]),
pri(s0g93, [189]),
pri(s0g94, [190, 191, 192]),
pri(s0g95, [193, 194, 195]),
pri(s0g96, [196, 197]),
pri(s0g97, [198, 199, 200]),
pri(s0g98, [201, 202, 203]),
pri(s0g99, [204]),
pri(s1g0, [205, 113, 206]),
pri(s1g1, [71, 69]),
pri(s1g2, [207]),
pri(s1g3, [143]),
pri(s1g4, [110]),
pri(s1g5, [40, 33]),
pri(s1g6, [208, 209, 210]),
pri(s1g7, [20]),
pri(s1g8, [8, 151, 38]),
pri(s1g9, [149]),
pri(s1g10, [211]),
pri(s1g11, [65]),
pri(s1g12, [212]),
pri(s1g13, [102, 66, 213]),
pri(s1g14, [78]),
pri(s1g15, [191]),
pri(s1g16, [160]),
pri(s1g17, [153, 194, 70]),
pri(s1g18, [214, 159]),
pri(s1g19, [215, 216, 175]),
pri(s1g20, [189, 178, 217]),
pri(s1g21, [77]),
pri(s1g22, [147, 218, 219]),
pri(s1g23, [220, 93]),
pri(s1g24, [221, 54, 16]),
pri(s1g25, [162, 25, 176]),
pri(s1g26, [222, 223, 224]),
pri(s1g27, [225, 226, 227]),
pri(s1g28, [89, 228]),
pri(s1g29, [229, 230, 137]),
pri(s1g30, [201]),
pri(s1g31, [48, 231, 232]),
pri(s1g32, [155, 233]),
pri(s1g33, [11, 234]),
pri(s1g34, [46]),
pri(s1g35, [136]),
pri(s1g36, [57, 164, 235]),
pri(s1g37, [236]),
pri(s1g38, [237, 51, 166]),
pri(s1g39, [238]),
pri(s1g40, [239, 204, 86]),
pri(s1g41, [240]),
pri(s1g42, [183, 144]),
pri(s1g43, [134, 133, 241]),
pri(s1g44, [242, 171]),
pri(s1g45, [99]),
pri(s1g46, [42]),
pri(s1g47, [13]),
pri(s1g48, [243, 244]),
pri(s1g49, [120, 245]),
pri(s1g50, [246]),
pri(s1g51, [247]),
pri(s1g52, [50, 3]),
pri(s1g53, [248, 249]),
pri(s1g54, [98]),
pri(s1g55, [138, 250, 251]),
pri(s1g56, [14]),
pri(s1g57, [252, 253]),
pri(s1g58, [118, 84]),
pri(s1g59, [169]),
pri(s1g60, [135, 145]),
pri(s1g61, [64, 26]),
pri(s1g62, [196, 254]),
pri(s1g63, [255]),
pri(s1g64, [256, 131, 257]),
pri(s1g65, [79, 258, 112]),
pri(s1g66, [259, 260]),
pri(s1g67, [261]),
pri(s1g68, [173]),
pri(s1g69, [262]),
pri(s1g70, [263, 264, 265]),
pri(s1g71, [266]),
pri(s1g72, [116, 200]),
pri(s1g73, [28, 96]),
pri(s1g74, [170, 267]),
pri(s1g75, [268]),
pri(s1g76, [269, 202]),
pri(s1g77, [91, 44]),
pri(s1g78, [61, 2, 270]),
pri(s1g79, [141]),
pri(s1g80, [95]),
pri(s1g81, [271, 154, 130]),
pri(s1g82, [272]),
pri(s1g83, [273, 190, 168]),
pri(s1g84, [274, 174]),
pri(s1g85, [192, 172]),
pri(s1g86, [275, 36]),
pri(s1g87, [197, 12]),
pri(s1g88, [167, 6]),
pri(s1g89, [276, 277]),
pri(s1g90, [125, 23, 139]),
pri(s1g91, [278]),
pri(s1g92, [279, 199]),
pri(s1g93, [182, 280]),
pri(s1g94, [281, 282, 283]),
pri(s1g95, [284, 103, 285]),
pri(s1g96, [286, 15, 152]),
pri(s1g97, [101]),
pri(s1g98, [287, 114]),
pri(s1g99, [85, 195, 60]),
pri(s2g0, [88, 288]),
pri(s2g1, [146, 141]),
pri(s2g2, [289, 290]),
pri(s2g3, [74]),
pri(s2g4, [212]),
pri(s2g5, [250]),
pri(s2g6, [111, 291]),
pri(s2g7, [75]),
pri(s2g8, [9, 156, 29]),
pri(s2g9, [155, 279, 221]),
pri(s2g10, [43, 292]),
pri(s2g11, [11, 267, 293]),
pri(s2g12, [294, 110]),
pri(s2g13, [65]),
pri(s2g14, [295]),
pri(s2g15, [27, 296]),
pri(s2g16, [208, 297, 251]),
pri(s2g17, [163, 209, 140]),
pri(s2g18, [213, 82, 107]),
pri(s2g19, [31, 298, 299]),
pri(s2g20, [217, 115]),
pri(s2g21, [85, 108, 258]),
pri(s2g22, [300, 262]),
pri(s2g23, [224]),
pri(s2g24, [124, 69, 72]),
pri(s2g25, [245, 60, 28]),
pri(s2g26, [186, 301]),
pri(s2g27, [229, 188, 18]),
pri(s2g28, [91]),
pri(s2g29, [174, 149]),
pri(s2g30, [51, 103]),
pri(s2g31, [265, 125, 239]),
pri(s2g32, [158, 302, 303]),
pri(s2g33, [304]),
pri(s2g34, [305, 260, 53]),
pri(s2g35, [47, 306, 20]),
pri(s2g36, [143, 98, 84]),
pri(s2g37, [30]),
pri(s2g38, [272]),
pri(s2g39, [13, 307, 269]),
pri(s2g40, [223]),
pri(s2g41, [231]),
pri(s2g42, [119, 234, 235]),
pri(s2g43, [25]),
pri(s2g44, [308]),
pri(s2g45, [309, 191]),
pri(s2g46, [310, 100, 192]),
pri(s2g47, [41, 187]),
pri(s2g48, [3, 46, 104]),
pri(s2g49, [136]),
pri(s2g50, [311, 271]),
pri(s2g51, [230, 14]),
pri(s2g52, [166, 179]),
pri(s2g53, [312]),
pri(s2g54, [21]),
pri(s2g55, [219, 189]),
pri(s2g56, [38, 59, 62]),
pri(s2g57, [244]),
pri(s2g58, [127, 263, 96]),
pri(s2g59, [282, 313, 130]),
pri(s2g60, [45, 190]),
pri(s2g61, [314, 315]),
pri(s2g62, [165]),
pri(s2g63, [180, 12, 196]),
pri(s2g64, [83, 254]),
pri(s2g65, [316]),
pri(s2g66, [317]),
pri(s2g67, [318]),
pri(s2g68, [319, 320]),
pri(s2g69, [280, 321]),
pri(s2g70, [154, 237, 181]),
pri(s2g71, [211, 81, 201]),
pri(s2g72, [210, 206]),
pri(s2g73, [322]),
pri(s2g74, [144, 90, 287]),
pri(s2g75, [92, 19]),
pri(s2g76, [232]),
pri(s2g77, [220, 323, 324]),
pri(s2g78, [133]),
pri(s2g79, [77]),
pri(s2g80, [37, 102]),
pri(s2g81, [135, 6, 139]),
pri(s2g82, [256, 16]),
pri(s2g83, [227, 218]),
pri(s2g84, [197]),
pri(s2g85, [40, 325, 99]),
pri(s2g86, [184]),
pri(s2g87, [249]),
pri(s2g88, [326, 123]),
pri(s2g89, [151]),
pri(s2g90, [114, 198, 266]),
pri(s2g91, [109, 274, 327]),
pri(s2g92, [214, 169]),
pri(s2g93, [328]),
pri(s2g94, [121, 203, 113]),
pri(s2g95, [67, 33, 50]),
pri(s2g96, [329]),
pri(s2g97, [70, 167, 330]),
pri(s2g98, [152, 238]),
pri(s2g99, [286, 71, 112])]).
