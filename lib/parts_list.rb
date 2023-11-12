require 'csv'

module PartsList # rubocop:disable Metrics/ModuleLength
  # file = CSV.read('rv10section4parts.csv')
  # file = CSV.read('./lib/emp_part_list.csv')
  # file = %w[test one]
  parts = ['AA3-025X5/8X5/8X5"',
           "AA6-063X3/4X3/4X12'",
           'AA6-063X3/4X3/4X18',
           'AA6-125X1X1 1/4X5',
           'AA6-125X1X1X17',
           'AA6-125X3/4X3/4X17',
           'AA6-125X3/4X3/4X98.5',
           'AA6-187X2X2 1/2X5',
           'AB4-125X1 1/2X8',
           'AEX TIE DOWN X7.5',
           "AN257-P3X6'",
           'AS3-016 VV CUT',
           'AS3-020 VV CUT',
           'AS3-020X4"X5"',
           'AS3-025 VV CUT',
           'AS3-032 VV CUT',
           'AS3-032X4X5',
           'AS3-040 VV CUT',
           'AS3-063 VV CUT',
           'AS3-063X0.5X1.4375',
           'AS3-125 VV CUT',
           'AS3-125X1X13',
           'AT6-035X1 1/2X83',
           'BEARING DW4K2X',
           'BEARING MD3614M',
           'BEARING MD3616M',
           'BEARING MW-3M',
           'BOLT HEX 1/4X28-8',
           'BUSHING SB625-7',
           'BUSHING SB625-8',
           'CT Q-43',
           'DWG 1 RV-10',
           'DWG 2 RV-10',
           'DWG OP-51',
           'E-1001A',
           'E-1001B',
           'E-1002',
           'E-1007',
           'E-1008',
           'E-1015',
           'E-1017',
           'E-1018',
           'E-1019',
           'E-1020',
           'E-1022',
           'E-614',
           'E-615PP',
           'E-616PP',
           'E-903',
           'E-904',
           'E-905',
           'E-910',
           'E-912',
           'E-913',
           'E-917',
           'E-918',
           'E-919',
           'E-920',
           'E-921',
           'E-DRILL BUSHING',
           'ES MSTS-8A',
           'F-1006',
           'F-1006A',
           'F-1006B',
           'F-1006C',
           'F-1006D',
           'F-1006E',
           'F-1006F',
           'F-1007',
           'F-1008',
           'F-1009',
           'F-1010A',
           'F-1010B',
           'F-1010C',
           'F-1011',
           'F-1011A',
           'F-1011C',
           'F-1011E',
           'F-1012',
           'F-1012A',
           'F-1012B',
           'F-1012E',
           'F-1014',
           'F-1015A',
           'F-1015B',

           'F-1028',
           'F-1029',
           'F-1032',
           'F-1035',
           'F-1036',
           'F-1037A',
           'F-1037B',
           'F-1037C',
           'F-1047',
           'F-1055',
           'F-1056',

           'F-1074',
           'F-1073',
           'F-1075',
           'F-1078',
           'F-1079',
           'F-1085',
           'F-1091',
           'F-1094A',
           'F-1095',
           'F-1095A',
           'F-1095B',
           'F-1095D',
           'F-1095E',
           'F-1095F',
           'F-1098',
           'F-635',
           'F-636',
           'F-824B',
           'FOAM,PVC-750X2X5.25',
           'HS-1001',
           'HS-1002',
           'HS-1003',
           'HS-1004',
           'HS-1007',
           'HS-1008',
           'HS-1013',
           'HS-1014',
           'HS-1015',
           'HS-1016',
           'HS-904',
           'HS-905',
           'HS-906',
           'HS-910',
           'HS-911',
           'HS-912',
           "J-CHANNELX6'",
           "J-CHANNELX8'",
           'K1000-08',
           'K1000-3',
           'K1100-06',
           'PS UHMW-125X1/2X2',
           'PS UHMW-125X1X2',
           'R-01007A-1',
           'R-01007B-1',
           'R-1001',
           'R-1002',
           'R-1003',
           'R-1004A',
           'R-1004B',
           'R-1005',
           'R-1006',
           'R-1009',
           'R-1010',
           'R-1011',
           'R-1012',
           'R-1014',
           'R-1015',
           'R-607PP',
           'R-608PP',
           'RIVET AD-41-ABS',
           'RIVET CCR-264SS-3-2',
           'RIVET CS4-4',
           'RIVET LP4-3',
           'RIVET MK-319-BS',
           'RIVET MSP-42',
           'TRIM BUNDLE, EMP',
           'VA-101',
           'VA-137',
           'VA-140',
           'VA-146',
           'VA-169',
           'VS-01010-1',
           'VS-1001',
           'VS-1002',
           'VS-1003',
           'VS-1004',
           'VS-1005',
           'VS-1006',
           'VS-1007',
           'VS-1008',
           'VS-1009',
           'VS-1011',
           'VS-1012',
           'VS-1013',
           'VS-1014',
           'VS-1015',
           'VS-1016',
           'VS-1017',
           'WASHER 5702-475-48 Z3',
           'WASHER 5702-95-30',
           'WD-415-1',
           'WD-605',
           # wing parts
           'A-1001A-1L',
           'A-1001A-1R',
           'A-1001B-1',
           'A-1002-1',
           'A-1003-1',
           'A-1004-1R',
           'A-1004-1L',
           'A-1005-1',
           'A-1005A-1L',
           'A-1005A-1R',
           'A-1006-1A',
           'A-1006-1B',
           'A-1007-1A',
           'A-1007-1B',
           'A-1007-1C',

           'A-1008-1',
           'A-1011',
           'A-1015-1L',
           'A-1015-1R',
           'A-710',
           'AA6-063X3/4X3/4X12',
           'AA6-063X3/4X3/4X18',
           'AEX TIE DOWN X7.5',
           'AS3-016',
           'AS3-020',
           'AS3-025',
           'AS3-032',
           'AS3-040',
           'AS3-063',
           'AS3-063X5/8X13 1/2',
           'AS3-125 VV CUT',
           'AT0-032X1/4X19',
           'AT6-049X1.25X8',
           'AT6-058X5/16X4',
           'BEARING CM-4M',
           'BEARING COM-3-5',
           'CAV-110',
           'DOC W/TIP LENS 7/9',
           'ES AUDIO WARN',
           'ES E22-50K MICRO SW',
           'FL-1001A',
           'FL-1001B',
           'FL-1001C',
           'FL-1002',
           'FL-1003',
           'FL-1004',
           'FL-1005',
           'FL-1006',
           'FL-1007',
           'FL-1008',
           'FL-1009A',
           'J-CHANNELX6',
           'J-CHANNELX8',
           'ST304-065X1.375X34.62',
           'ST4130-035X1/2X48-PC',
           'ST4130-035X7/8X22',
           'T-00007-1',
           'T-1001',
           'T-1002',
           'T-1003',
           'T-1003B',
           'T-1003C',
           'T-1004',
           'T-1005',
           'T-1005BC',
           'T-1010',
           'T-1011',
           'T-1012',
           'VA-140',
           'VA-141',
           'VA-146',
           'VA-193',
           'VA-195A',
           'VA-195B',
           'VA-195C',
           'VA-195D',
           'VA-196',
           'VA-261',
           ' VA-4908P',
           'W-00007CD',
           'W-1001',
           'W-1002',
           'W-1003',
           'W-1004',
           'W-1005',
           'W-1006',
           'W-1006E',
           'W-1006F',
           'W-1007A',
           'W-1007B',
           'W-1007C',
           'W-1007D',
           'W-1007E',
           'W-1008',
           'W-1009',
           'W-1010',
           'W-1011',
           'W-1012',
           'W-1013',
           'W-1013A',
           'W-1013C',
           'W-1013C-LX',
           'W-1013C-RX',
           'W-1013D',
           'W-1013E',
           'W-1013F',
           'W-1013G',
           'W-1014',
           'W-1015',
           'W-1016',
           'W-1017',

           ' W-1018A',
           'W-1019',
           'W-1020',

           'W-1021',
           'W-1021B',
           'W-1024',
           'W-1025A',

           'W-1025B',
           'W-1026',
           'W-1027A',
           'W-1027B',
           'W-1029A',
           'W-1029B',
           'W-1029D',
           'W-1029E',

           'W-730',
           'W-822PP',
           'W-823PP-PC',
           'WD-1014-PC',
           'WD-1014',
           'WD-1014C',

           'WD-421',
           'W-SPAR ASSY',
           'W-1028A',
           'W-1028B',
           'J-STIFFENER',
           'W-823PP',
           'ES E22-50k',
           'ES DV18-188M',
           'WH-F1001',
           # fuselage
           'BEARING CM-4M',
           'BEARING COM-3-5',
           'BEARING MD3616M',
           'C-1001',
           'C-1004',
           'C-1005',
           'ES-FA-PA-270-12-5',
           'F-01002',
           'F-01004A',
           'F-01004C',

           'F-01004K',
           'F-01004P',
           'F-01004T',
           'F-01042',
           'F-01042BCD-1',
           'F-01043B',
           'F-01043D',
           'F-01043G',
           'F-01049C',
           'F-01050',
           'F-01057',
           'F-01067A-1',
           'F-01067C-1',
           'F-01067D-1',
           'F-01069',
           'F-01072-1',
           'F-01088',
           'F-1001A',
           'F-1001B',
           'F-1001C',
           'F-1001D',
           'F-1001E',
           'F-1001F',
           'F-1001G',
           'F-1001J',
           'F-1001K',
           'F-1001M',
           'F-1003A',
           'F-1003B',
           'F-1003C',
           'F-1004-SPACR-063',
           'F-1004-SPACR-125',
           'F-1004AFT',
           'F-1004B',
           'F-1004D',
           'F-1004J',
           'F-1004L',
           'F-1004R',
           'F-1004S',
           'F-1004N',
           'F-1004M',
           'F-1005A',
           'F-1005B',
           'F-1005C',
           'F-1005D',
           'F-1005E',
           'F-1013',
           'F-10100A',
           'F-10100B',
           'F-10102A',
           'F-10102B',
           'F-10101',
           'F-10105',
           'F-10107',
           'F-1015A',
           'F-1015B',
           'F-1015C',
           'F-1015D',
           'F-1015E',
           'F-1015F',
           'F-1015EF',
           'F-1016B',
           'F-1016C',
           'F-1016D',
           'F-1016D-1',
           'F-1016E',
           'F-1016F',
           'F-1016G',
           'F-1016H',
           'F-1017A',
           'F-1017B',
           'F-1017C',
           'F-1018',
           'F-1019',
           'F-1020',
           'F-1021',
           'F-1022',
           'F-1022A',
           'F-1023',
           'F-1023B',
           'F-1024',
           'F-1025',
           'F-1026',
           'F-1027',
           'F-1030',
           'F-1031',
           'F-1033',
           'F-1034A',
           'F-1034B',
           'F-1034C',
           'F-1034D',
           'F-1034E',
           'F-1034F',
           'F-1038',
           'F-1039A',
           'F-1039B',
           'F-1039D',
           'F-1039J',
           'F-1040',
           'F-1041',
           'F-1042E-L/R',
           'F-1042F',
           'F-1042G',
           'F-1043A',
           'F-1043C',
           'F-1043E',
           'F-1043F',
           'F-1044A',
           'F-1044DEF',
           'F-1045',
           'F-1046',
           'F-1046B',
           'F-1048',
           'F-1048C-1',
           'F-1048D',
           'F-1048F',
           'F-1048G',
           'F-1049A',
           'F-1049B',
           'F-1049D',
           'F-1050B',
           'F-1051A',
           'F-1051C',
           'F-1051E',
           'F-1051F',
           'F-1051G',
           'F-1051J',
           'F-1052',
           'F-1052B',
           'F-1052C',
           'F-1053',
           'F-1058',
           'F-1059A',
           'F-1059B',
           'F-1059C',
           'F-1059D',
           'F-1059E',
           'F-1059F',
           'F-1061',
           'F-1062-1',
           'F-1063A',
           'F-1063B',
           'F-1064',
           'F-1065',
           'F-1066A-1',
           'F-1066B-2',
           'F-1066C-2',
           'F-1067B',
           'F-1068A',
           'F-1068B',
           'F-1070',
           'F-1071',
           'F-1071B',
           'F-1076',
           'F-1077',
           'F-1080',
           'F-1081',
           'F-1083',
           'F-1084',
           'F-1086',
           'F-1087',
           'F-1092',
           'F-1093',
           'F-1094B',
           'F-1096',
           'F-1099A',
           'F-1099B',
           'F-1099C',
           'F-1099D',
           'F-1099EFG',
           'F-6114',
           'F-6114A',
           'F-6115',
           'F-6122-1',
           'F-637A',
           'F-814HPP',
           'F-DRILL BUSHING',
           'FUEL VALVE',
           "HINGE PIANO 1/8X6'",
           "HINGE PIANO 1/8X9' ML",
           'PS UHMW-125X1/2X2',
           'PS UHMW-125X1/2X5',
           'PS UHMW-125X1X2',
           'PT 1/2ODX2 CLEAR',
           "RUBBER CHANNEL X 4'",
           'SS4130-050X1/2X4',
           'TOOL 3" CUTTING DISC',
           'TRIM BUNDLE-FUS',
           'VA-00272',
           'VA-00273',
           'VA-00274',
           'VA-00275',
           'VA-00277',
           'VA-00278',
           'VA-101',
           'VA-107',
           'VA-146',
           'VA-175',
           'VA-178A',
           'VA-178B',
           'VA-178G',
           'VA-188',
           'VENT DL-03',
           'VENT DL-10',
           'VENT TG-10',
           'VENT TG-1010',
           'VENT-00004',
           'WD-01021',
           'WD-1002',
           'WD-1003',
           'WD-1004',
           'WD-1006',
           'WD-1007',
           'WD-1008',
           'WD-1010',
           'WD-1011',
           'WD-1012',
           'WD-1013A',
           'WD-1013B',
           'WD-1013C',
           'WD-1043'].freeze

  # file.each { |c| parts << c[0] }
  define_method(:getParts) { parts }
end

# documenting for later use
# copy hash or array without modifying the original
def deep_copy(o)
  Marshal.load(Marshal.dump(o))
end
