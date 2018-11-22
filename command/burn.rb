# frozen_string_literal: true

require 'thor'

require_relative '../model'
require_relative '../template'
require_relative '../model/config'
require_relative '../model/depends'

# generate plugin & plugin config
class CLI < Thor
  FIRE = [
    "!!", "````",
    "あ", "FE",
    "ひ", "6H",
    "る", "pW",
    "焼", "5)",
    "き", "66",
    "て", "Mq",
    "お", "'M",
    "く", "WN",
    "れ", "HE",
    "|", "WW",
    "x", "6N",
    "t", "\nG",
    "c", "'*",
    "]", " .",
    "[", "HH",
    "Z", "'N",
    "P", "*H",
    "L", "WH",
    "G", "55",
    "F", "'H",
    "E", "MH",
    "6", "''",
    "5", "))",
    "*", "MN",
    ")", "  ",
    "'", "MM"
  ].freeze
  DUCK = "GG5]ggggggggggggg,tG]dPEあ6m*く-..t焼(gg6Zききme.t5(dNc'#TM9くHNN*WZx*J.t)]dひ'K` _` (W*ひひ'LH-\n -.],.(,]\"THZ*9^5 (て*'m*x6:\n].G OPて'm.5(て6m*Fひ*r\n ?`G JLHB7XN*a&gadきPEPてM$\n)],焼]d'WM9L[YWFHあHP*F*M%\n) _jy焼(PNHQkFQkIjHkMDjW#H6おD+くr\n焼 ?u,)?xHFLN[EHFcZあY^t `.WQひ>vLEH'WひxHひN{GG)].jm..t57LMくHQgS7Pkj[*くPE&dHMKY!GG]J[pFa,t5 7HVT[H'kWUWる*'kH*'kWojK3`G焼].dMR(dpUUL&.t焼(kdLHbれQ2jるPMm*KjWbWY!G焼]gW'kpp|mdLMst5 ?WpRJdMBTWPpる*L*'kWB!G焼]+る*FR&dFLMDt)]uAXれEWkWFS<X[SjW*M#<.G])(mAQLS<XPれ'L[Mb.t)(EppmJXNZKYWbるEMB7WPるMnJ, (JJ((HodV7WEHNbWYUれMY4kJ*'#~t.+HR+dUL#HFNk*k(X'Wd[H$(k+dUWXWUWpR(dpkAJdUL|mkれLHkWx..\n焼 J/OppるAdW*お#=L0?WCOれYUbWZmuるAdf?UCXbWEAdNWcWFP*c}\n5][VLる&jHFF*ks(TEkn(XWあHnJる&j0T|LBHLBbWMegP&d6x}\n) (md|Qk81XpCzN*6[CidL[F6FHNH|kd|WkdEAd|L[F'W6c;\n).dR(XYH'EppHMm6EY4pLogpk+d[れojれ&gn(k&?4LH'k(XMhJ[agZ6'B^\n]d'EQあldれ**qMkXkWZ|EあMR(WEp0(Xp>(WL'WUWPて'P6Zl\n.*PE*くHM8CWZZHpY4W*'くY4P*VCWMY4f7U=4[+X[kJXPて*c6'$\n.きP'|F*KUWpHNW*あひ9|M9WVUXR~jbRJdHKUWひ*きお$\n.xZM8?HCOHZZeXpH6[**'EAdbk&dkdR<udHFHkdL6q*Z6お$\n.ZF*'WM9ULxHLP'h(H*P*あ&jUTW+dUTEおW+dP*F6お#=\n ?'PcWMkdHて*PQkPFHてxZR?X|kz<X|mWcくNH6c6*}\n)dN'9WM9T|agHてP*YWP*fTxZH*bW&dn(k&?4れZNZれZ6'#9!\n)_TEXEkXW6れ*Lk'E'Wd6EEH'R<dI(R+LくH6EFき'#!\n5(EN'07*Z*M87E*cZNc+d'くHCwf?くNxxZ*6'B=\n5 (WおWk6Eあ6EPFPEMBUHKVW04WEcZH6てZ'#>\n焼?7Wc*'EPExき6mdEAdWgkQk6xNcお#=`t ?TW6ZPx6*E6*ZKYUL*6cN*6B>t5?HFきき6E'EEmk[Hきお=X9?!`tG)7!(\"7\"\"LTM@cx*Pお#4mYW#\"\"\"\"^.\"`tGG)` `)!!!!!!!!` `)`\n"

  desc 'burn', 'Burn duck'
  method_option :duration, type: :numeric
  def burn
    if options[:duration]
      puts FIRE.each_slice(2).inject(DUCK){|i,j|puts i; sleep options[:duration].to_f/1000 ; i.gsub(*j)}
    else
      puts FIRE.each_slice(2).inject(DUCK){|i,j|i.gsub(*j)}
    end
  end
end
