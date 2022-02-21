-- tek satır yorum
--[[
    bu dosya Lua programlama dilini öğrenmek isteyenler için hazırlanmıştır.
    [1]'den çalışılırken alınan notların Türkçe olarak kazanımı amaçlanmıştır.
    Önemli Not: notlar kendimcedir, içindeki zımbırtılara değişken isimlerine vs takılmayınız.
    Önemli Not2: okunurken dinlenmesi tavsiye olunur: https://www.youtube.com/watch?v=x8gvieju6bg
    Önemli Not3: IDE olarak ZeroBrane Studio önerilir [2]'de var.
    [1]:http://tylerneylon.com/a/learn-lua/
    [2]:https://studio.zerobrane.com/download?not-this-time
--]]
--------------------------------------------------------------
sayi = 40
-- tüm sayılar double türünde
-- 64 bit double 52 bit int saklayabilmeyi sağlıyor
stringS = 'tekli kesme kullanılıyor'
stringSS = "çift kesme de olur"
stringSSS = [[
Çoklu satır da kullanılabilir
]]
strings = nil
--strings tanımsız, garbage collector var olsun!

while sayi < 50 do
  sayi = sayi + 1 -- do ile end yazıp enterlayınca blok yapısını takmanıza gerek yok
end

if sayi > 45 then
  print("tamamdır")
elseif stringS ~= "esit degilse" then
  io.write('esit degilmis\n')
else
  globaldegisken = 5
  local line = io.read() --satır okur
  print('stringler bu operator ile' .. line)
end
tanimsizdegisken = hicolmayandegisken
-- buradaki kod satırının çoğu dilde hata vermesi gerekmektedir lâkin lua'da vermez
-- çünkü lua tümevarımdan gider: hicolmayandegisken = nil => tanimsizdegisken = hicolmayandegisken then tanimsizdegisken = nil

ikilikdegisken = true

-- yalnızca nil ve false hatalı dönderir, 0 ve '' true dönderir
if not ikilikdegisken then print('aga be') end
cevap = ikilikdegisken and 'aga' or 'be'
-- burada aga ve be kısa devredir

toplam = 0
for i=1,100 do
  toplam= toplam+i
end

for j=100,1,-1 do toplam=toplam+j end
-- başlangıç,son,adım

repeat
  print("gelecek ")
  sayi = sayi - 100
until sayi < 0


function fib(n)
  if n<2 then return 1 end
  return fib(n-2) + fib(n-1)
end
function adder(x)
  return function (y) return x+y end
end
a1 = adder(29)
print(a1(5))

x, y, z, k = 1,2,3,4,5
-- x=1 y=2 z=3 k=4 5 ırkçılığa maruz kalmış yer bulamamış kendine

function varim(a,b,c)
  print(a,b,c)
  return 1,2,3,4,5,6,7,8
end
x, y = varim("valide") -- çıktı olarak "valide nil nil" basar verir
-- x=1, y=2 olur diğerleri ırkçılığa maruz kalmış

function f(x) return x*x end
f = function(x) return x*x end
-- 75 ve 76. satirlardaki fonksiyon tanımlamaları aynıdır.

local function g(x) return math.sin(x) end
local g; g = function (x) return mah.sin(x) end
-- burada local g'deki kasıt kendi kendini refere ettiğini göstermek
-- ayrıca trigonometrik fonksiyonlar radyanla çalışır
-- fonksiyon çağrılarında(func calls) tek stringle çalışan fonksiyonlarda parantezlere ihtiyaç duymayız
print "valide"


-- tablolar Lua'daki bileşik bir veri yapısıdır ayrıca ilişkili diziler bütünlüğüdür.
tabloT = {anektar1="value", anektar2= false}
print(tabloT.anektar1) --burada yaygın . notasyonu ile tablo elemanına erişim sağlanmaktadır
tabloT.yenianektar = {} --tabloya yeni bir anektar eklemek için
tabloT.anektar2 = nil -- anektar2yi tablodan sildik

--tablolarda herhangi var olan bir şey anektar olabilir, Literal notation
tabloDegisik = {['valide']='sizin', [6.28]='u', [{}]=1071}
print(tabloDegisik['valide']) -- 'sizin' çıktısı
print(tabloDegisik[{}]) -- nil çıktısı


function tabloH(x) print(x.anektar1) end
tabloH{anektar1="valideniz"}   --valideniz çıktısı verir

for anektar, deger in pairs(tabloDegisik) do
  print(anektar, deger)
end

print(_G['_G'] == _G)   --true çıktısı verir
-- çünkü _G özel bir tablodur tüm globalleri içeren

-- Tabloları dizi/liste şeklinde kullanımda mümkündür
v = {'deger1', 'deger2', 1.907}
for i=1, #v do --buradaki #v v tablosundaki anektar sayisini gösterir
  print(v[i]) -- ayrıca indisin 1'den başladığını unutmayalım
end
-- list gerçek bir veri yapısı değildir, buradaki v yalnızca bir tablo
-- sadece indisli mindisli print edince list gibi davranıyor/vaziyet alıyor


-- metamethod ve metatable denen zımbırtılar

f1 = {a=1, b=2} --a/b fraksiyonunu gösterir
f2 = {a=2, b=3}

-- fToplamı= f1+f2 hata verir

metafraction = {}
function metafraction.__add(f1 ,f2)
  sum = {}
  sum.b = f1.b * f2.b
  sum.a = f1.a * f2.b + f1.b * f2.a
  return sum
end

setmetatable(f1, metafraction)
setmetatable(f2, metafraction)

s = f1 + f2  -- f1'in metatablosunda __add(f1, f2) çağrılır

--[[
burasının önemli olduğunu düşündüğüm için direk yapppppppppıştırdım
-- f1, f2 have no key for their metatable, unlike
-- prototypes in js, so you must retrieve it as in
-- getmetatable(f1). The metatable is a normal table
-- with keys that Lua knows about, like __add.

-- But the next line fails since s has no metatable:
-- t = s + s
-- Class-like patterns given below would fix this.

-- An __index on a metatable overloads dot lookups:
defaultFavs = {animal = 'gru', food = 'donuts'}
myFavs = {food = 'pizza'}
setmetatable(myFavs, {__index = defaultFavs})
eatenBy = myFavs.animal  -- works! thanks, metatable

-- Direct table lookups that fail will retry using
-- the metatable's __index value, and this recurses.

-- An __index value can also be a function(tbl, key)
-- for more customized lookups.

-- Values of __index,add, .. are called metamethods.
-- Full list. Here a is a table with the metamethod.

-- __add(a, b)                     for a + b
-- __sub(a, b)                     for a - b
-- __mul(a, b)                     for a * b
-- __div(a, b)                     for a / b
-- __mod(a, b)                     for a % b
-- __pow(a, b)                     for a ^ b
-- __unm(a)                        for -a
-- __concat(a, b)                  for a .. b
-- __len(a)                        for #a
-- __eq(a, b)                      for a == b
-- __lt(a, b)                      for a < b
-- __le(a, b)                      for a <= b
-- __index(a, b)  <fn or a table>  for a.b
-- __newindex(a, b, c)             for a.b = c
-- __call(a, ...)                  for a(...)
--]]

-- sınıflar yerleşik(built-in) şeysiler değildir Lua'da bu yüzden onları yapmanın birden çok yolu vardır
-- tablolar ve metatabloları kullanarak

Kopek = {} -- Kardeş Payı Büyük Hilmi şivesiyle

function Kopek:yeni()
  yeni_nesne = {ses = 'havhav'}
  self.__index = self
  return setmetatable(yeni_nesne, self)
end

function Kopek:sesVer()
  print(self.ses .. ' derim.')
end


disiKopek = Kopek:yeni()
disiKopek:sesVer()
--------- buradaki açıklamayı da çevirme niyetim yok ------
-- 190. Dog acts like a class; it's really a table.
-- 192. function tablename:fn(...) is the same as
--    function tablename.fn(self, ...)
--    The : just adds a first arg called self.
--    Read 7 & 8 below for how self gets its value.
-- 193. newObj will be an instance of class Dog.
-- 194. self = the class being instantiated. Often
--    self = Dog, but inheritance can change it.
--    newObj gets self's functions when we set both
--    newObj's metatable and self's __index to self.
-- 195. Reminder: setmetatable returns its first arg.
-- 198. The : works as in 2, but this time we expect
--    self to be an instance instead of a class.
-- 203. Same as Dog.new(Dog), so self = Dog in new().
-- 204. Same as mrDog.makeSound(mrDog); self = mrDog.
------------------------------------------------------------

--bir de kalıtım örneği lazım tabi

sesliKopek = Kopek:yeni()

function sesliKopek:sesVer()
  sess = self.ses .. ' '
  print(sess .. sess)
end
altay = sesliKopek:yeni()
altay:sesVer()

--[[
gene çevirmeye lüzum görmedim satır numaralarını zaten atıyorum
-- 225. LoudDog gets Dog's methods and variables.
-- 228. self has a 'sound' key from new(), see 3.
-- 231. Same as LoudDog.new(LoudDog), and converted to
--    Dog.new(LoudDog) as LoudDog has no 'new' key,
--    but does have __index = Dog on its metatable.
--    Result: seymour's metatable is LoudDog, and
--    LoudDog.__index = LoudDog. So seymour.key will
--    = seymour.key, LoudDog.key, Dog.key, whichever
--    table is the first with the given key.
-- 232. The 'makeSound' key is found in LoudDog; this
--    is the same as LoudDog.makeSound(seymour).
--]]

--ihtiyaç duyulursa altsınıfın yeni() fonksiyonu üst sınıfınkine temel olarak şu şekilde benzer:
function sesliKopek:yeni()
  yeni_nesne = {}
  self.__index = self
  return setmetatable(yeni_nesne, self)
end

--modul kısmı vardı ilgili bağlantıda onu da direk yapıştırayım canım isterse bu kısım da dahil tüm güzel ama ingiliççe kısımları kendimce notlandırmak suretinde düzenleyeceğim.
-- özet geç pakize: başka bir dosyada yazdıklarınızı çalıştığınız dosyaya nasıl aktaracağınız ve/veya çıkartacağınızın raconunu anlatıyor, klasik export işte tatavaya gerek yok.

--[[ I'm commenting out this section so the rest of
--   this script remains runnable.
--]]
-- Suppose the file mod.lua looks like this:
local M = {}

local function sayMyName()
  print('Hrunkner')
end

function M.sayHello()
  print('Why hello there')
  sayMyName()
end

return M

-- Another file can use mod.lua's functionality:
local mod = require('mod')  -- Run the file mod.lua.

-- require is the standard way to include modules.
-- require acts like:     (if not cached; see below)
local mod = (function ()
  <contents of mod.lua>
end)()
-- It's like mod.lua is a function body, so that
-- locals inside mod.lua are invisible outside it.

-- This works because mod here = M in mod.lua:
mod.sayHello()  -- Says hello to Hrunkner.

-- This is wrong; sayMyName only exists in mod.lua:
mod.sayMyName()  -- error

-- require's return values are cached so a file is
-- run at most once, even when require'd many times.

-- Suppose mod2.lua contains "print('Hi!')".
local a = require('mod2')  -- Prints Hi!
local b = require('mod2')  -- Doesn't print; a=b.

-- dofile is like require without caching:
dofile('mod2.lua')  --> Hi!
dofile('mod2.lua')  --> Hi! (runs it again)

-- loadfile loads a lua file but doesn't run it yet.
f = loadfile('mod2.lua')  -- Call f() to run it.

-- loadstring is loadfile for strings.
g = loadstring('print(343)')  -- Returns a function.
g()  -- Prints out 343; nothing printed before now.

-- kurtlar vadisi LUA operasyonu iyisiyle kötüsüyle bitmiştir.