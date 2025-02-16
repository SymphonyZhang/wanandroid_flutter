/// curPage : 1
/// datas : [{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>在我们的印象里，如果构造一个 Dialog 传入一个非 Activiy 的 context，则可能会出现 bad token exception。</p>\r\n<p>今天我们就来彻底搞清楚这一块，问题来了：</p>\r\n<ol>\r\n<li>为什么传入一个非 Activity 的 context 会出现错误？</li>\r\n<li>传入的 context 一定要是 Activity 吗？</li>\r\n</ol>","envelopePic":"","id":348301,"link":"https://www.wanandroid.com/wenda/show/18281","niceDate":"1小时前","origin":"","originId":18281,"publishTime":1739629466000,"title":"每日一问 | Dialog 的构造方法的 context 必须传入 Activity吗？","userId":165626,"visible":0,"zan":0},{"author":"","chapterId":502,"chapterName":"自助","courseId":13,"desc":"","envelopePic":"","id":346877,"link":"https://juejin.cn/post/7454386729702375465","niceDate":"2025-01-07 20:54","origin":"","originId":29354,"publishTime":1736254470000,"title":"庆元旦，出排名，手撸全网火爆的排名视频，排名动态可视化","userId":165626,"visible":0,"zan":0},{"author":"xiaoyang","chapterId":440,"chapterName":"官方","courseId":13,"desc":"<p>最近一直在补一些 C/C++的知识，导致 Android 相关知识看的少了，导致每日一问憋半天憋不出来。</p>\r\n<p>还好，我又更新了...</p>\r\n<p>之前公众号推文的时候，推送到混淆的时候，经常会说到「脱糖」，也有同学在留言区问什么是脱糖呀？</p>\r\n<p>今天的问题就是为了带大家彻底搞清楚什么是脱糖：</p>\r\n<ol>\r\n<li>脱糖产生的原因是什么？</li>\r\n<li>脱糖在 D8 产生后发生了什么变化？</li>\r\n<li>脱糖我们需要关注吗？在我们做什么事情的时候可能会影响到呢？</li>\r\n</ol>\r\n<p>求解答~</p>","envelopePic":"","id":346318,"link":"https://www.wanandroid.com/wenda/show/18615","niceDate":"2024-12-24 16:49","origin":"","originId":18615,"publishTime":1735030142000,"title":"每日一问 | 我们经常说到的 Android 脱糖指的是什么？","userId":165626,"visible":0,"zan":0}]
/// offset : 0
/// over : true
/// pageCount : 1
/// size : 20
/// total : 3

class MyCollectsListData {
  MyCollectsListData({
      this.curPage, 
      this.datas, 
      this.offset, 
      this.over, 
      this.pageCount, 
      this.size, 
      this.total,});

  MyCollectsListData.fromJson(dynamic json) {
    curPage = json['curPage'];
    if (json['datas'] != null) {
      datas = [];
      json['datas'].forEach((v) {
        datas?.add(MyCollectItemData.fromJson(v));
      });
    }
    offset = json['offset'];
    over = json['over'];
    pageCount = json['pageCount'];
    size = json['size'];
    total = json['total'];
  }
  num? curPage;
  List<MyCollectItemData>? datas;
  num? offset;
  bool? over;
  num? pageCount;
  num? size;
  num? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['curPage'] = curPage;
    if (datas != null) {
      map['datas'] = datas?.map((v) => v.toJson()).toList();
    }
    map['offset'] = offset;
    map['over'] = over;
    map['pageCount'] = pageCount;
    map['size'] = size;
    map['total'] = total;
    return map;
  }

}

/// author : "xiaoyang"
/// chapterId : 440
/// chapterName : "官方"
/// courseId : 13
/// desc : "<p>在我们的印象里，如果构造一个 Dialog 传入一个非 Activiy 的 context，则可能会出现 bad token exception。</p>\r\n<p>今天我们就来彻底搞清楚这一块，问题来了：</p>\r\n<ol>\r\n<li>为什么传入一个非 Activity 的 context 会出现错误？</li>\r\n<li>传入的 context 一定要是 Activity 吗？</li>\r\n</ol>"
/// envelopePic : ""
/// id : 348301
/// link : "https://www.wanandroid.com/wenda/show/18281"
/// niceDate : "1小时前"
/// origin : ""
/// originId : 18281
/// publishTime : 1739629466000
/// title : "每日一问 | Dialog 的构造方法的 context 必须传入 Activity吗？"
/// userId : 165626
/// visible : 0
/// zan : 0

class MyCollectItemData {
  MyCollectItemData({
      this.author, 
      this.chapterId, 
      this.chapterName, 
      this.courseId, 
      this.desc, 
      this.envelopePic, 
      this.id, 
      this.link, 
      this.niceDate, 
      this.origin, 
      this.originId, 
      this.publishTime, 
      this.title, 
      this.userId, 
      this.visible, 
      this.zan,});

  MyCollectItemData.fromJson(dynamic json) {
    author = json['author'];
    chapterId = json['chapterId'];
    chapterName = json['chapterName'];
    courseId = json['courseId'];
    desc = json['desc'];
    envelopePic = json['envelopePic'];
    id = json['id'];
    link = json['link'];
    niceDate = json['niceDate'];
    origin = json['origin'];
    originId = json['originId'];
    publishTime = json['publishTime'];
    title = json['title'];
    userId = json['userId'];
    visible = json['visible'];
    zan = json['zan'];
  }
  String? author;
  num? chapterId;
  String? chapterName;
  num? courseId;
  String? desc;
  String? envelopePic;
  num? id;
  String? link;
  String? niceDate;
  String? origin;
  num? originId;
  num? publishTime;
  String? title;
  num? userId;
  num? visible;
  num? zan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['author'] = author;
    map['chapterId'] = chapterId;
    map['chapterName'] = chapterName;
    map['courseId'] = courseId;
    map['desc'] = desc;
    map['envelopePic'] = envelopePic;
    map['id'] = id;
    map['link'] = link;
    map['niceDate'] = niceDate;
    map['origin'] = origin;
    map['originId'] = originId;
    map['publishTime'] = publishTime;
    map['title'] = title;
    map['userId'] = userId;
    map['visible'] = visible;
    map['zan'] = zan;
    return map;
  }

}