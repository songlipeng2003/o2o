## 接口变动记录

### 2015-07-09

* /orders/list_available_date 返回数据修改,修改为map格式
	`
	{
	    "2015-07-09": "今天",
	    "2015-07-10": "明天",
	    "2015-07-11": "后天",
	    "2015-07-12": "07-12",
	    "2015-07-13": "07-13",
	    "2015-07-14": "07-14",
	    "2015-07-15": "07-15"
	 }
	`
* /orders/list_available_time 返回数据修改,增加end_time服务结束时间,修复begin_time时间格式错误
  `
  [
    {
      "begin_time": "2015-07-09 08:00:00",
      "end_time": "2015-07-09 09:00:00",
      "text": "08:00-09:00",
      "result": false
    },
    {
      "begin_time": "2015-07-09 09:00:00",
      "end_time": "2015-07-09 10:00:00",
      "text": "09:00-10:00",
      "result": false
    },
    {
      "begin_time": "2015-07-09 10:00:00",
      "end_time": "2015-07-09 11:00:00",
      "text": "10:00-11:00",
      "result": false
    },
    {
      "begin_time": "2015-07-09 11:00:00",
      "end_time": "2015-07-09 12:00:00",
      "text": "11:00-12:00",
      "result": false
    },
    {
      "begin_time": "2015-07-09 12:00:00",
      "end_time": "2015-07-09 13:00:00",
      "text": "12:00-13:00",
      "result": false
    },
    {
      "begin_time": "2015-07-09 13:00:00",
      "end_time": "2015-07-09 14:00:00",
      "text": "13:00-14:00",
      "result": false
    },
    {
      "begin_time": "2015-07-09 14:00:00",
      "end_time": "2015-07-09 15:00:00",
      "text": "14:00-15:00",
      "result": false
    },
    {
      "begin_time": "2015-07-09 15:00:00",
      "end_time": "2015-07-09 16:00:00",
      "text": "15:00-16:00",
      "result": false
    },
    {
      "begin_time": "2015-07-09 16:00:00",
      "end_time": "2015-07-09 17:00:00",
      "text": "16:00-17:00",
      "result": false
    },
    {
      "begin_time": "2015-07-09 17:00:00",
      "end_time": "2015-07-09 18:00:00",
      "text": "17:00-18:00",
      "result": false
    },
    {
      "begin_time": "2015-07-09 18:00:00",
      "end_time": "2015-07-09 19:00:00",
      "text": "18:00-19:00",
      "result": false
    }
  ]
  `
* POST /orders 创建订接口增加booked_end_at服务结束时间，不传会自动生成，为服务开始时间后一个小时，以后必须填写
* GET /orders/lastest_order 增加最近订单接口
* GET /month_cards/available_count 增加可用消费卡数量接口
  `
  {
    "count": 1
  }
  `
* POST /orders/:id/evluation 增加score1,score2,score3参数，老接口传递score，新接口传递score1,score2,score3,后台会自动计算score为三个的平均值
