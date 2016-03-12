// All material copyright ESRI, All Rights Reserved, unless otherwise specified.
// See http://js.arcgis.com/3.16/esri/copyright.txt for details.
//>>built
define("esri/numberUtils",["dojo/has","dojo/number","dojo/i18n!dojo/cldr/nls/number","./kernel"],function(r,s,t,u){var v=function(c,b){return c-b},e={_reNumber:/^-?(\d+)(\.(\d+))?$/i,getDigits:function(c){var b=String(c),a=b.match(e._reNumber);c={integer:0,fractional:0};a&&a[1]?(c.integer=a[1].split("").length,c.fractional=a[3]?a[3].split("").length:0):-1<b.toLowerCase().indexOf("e")&&(a=b.split("e"),b=a[0],a=a[1],b&&a&&(b=Number(b),a=Number(a),(c=0<a)||(a=Math.abs(a)),b=e.getDigits(b),c?(b.integer+=
a,b.fractional=a>b.fractional?0:b.fractional-a):(b.fractional+=a,b.integer=a>b.integer?1:b.integer-a),c=b));return c},getFixedNumbers:function(c,b){var a,d;a=Number(c.toFixed(b));a<c?d=a+1/Math.pow(10,b):(d=a,a-=1/Math.pow(10,b));a=Number(a.toFixed(b));d=Number(d.toFixed(b));return[a,d]},getPctChange:function(c,b,a,d){var e={prev:null,next:null},f;null!=a&&(f=c-a,a=b-a-f,e.prev=Math.floor(Math.abs(100*a/f)));null!=d&&(f=d-c,a=d-b-f,e.next=Math.floor(Math.abs(100*a/f)));return e},round:function(c,
b){var a=c.slice(0),d,k,f,n,l,g,p,q,h,r=!b||null==b.tolerance?2:b.tolerance,m=b&&b.indexes,s=!b||null==b.strictBounds?!1:b.strictBounds;if(m)m.sort(v);else{m=[];for(g=0;g<a.length;g++)m.push(g)}for(g=0;g<m.length;g++)if(h=m[g],d=a[h],k=0===h?null:a[h-1],f=h===a.length-1?null:a[h+1],n=e.getDigits(d),n=n.fractional){p=0;for(q=!1;p<=n&&!q;)l=e.getFixedNumbers(d,p),l=s&&0===g?l[1]:l[0],q=e.hasMinimalChange(d,l,k,f,r),p++;q&&(a[h]=l)}return a},hasMinimalChange:function(c,b,a,d,k){c=e.getPctChange(c,b,
a,d);b=null==c.prev||c.prev<=k;a=null==c.next||c.next<=k;return b&&a||c.prev+c.next<=2*k},_reAllZeros:RegExp("\\"+t.decimal+"0+$","g"),_reSomeZeros:RegExp("(\\d)0*$","g"),format:function(c,b){b=b||{places:20,round:-1};var a=s.format(c,b);a&&(a=a.replace(e._reSomeZeros,"$1").replace(e._reAllZeros,""));return a}};r("extend-esri")&&(u.numberUtils=e);return e});