<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@include file="/commons/tag_libs.jsp"%>

<!DOCTYPE HTML>
<html>
<head>

<link href="${resource}/css/bootstrap.min.css" rel="stylesheet">
<link href="${css}/bootstrap-table.css" rel="stylesheet"/>
<link href="${css}/bootstrap-editable.css" rel="stylesheet"/>
<script src="${js}/jquery-1.11.1.js" ></script>
<script src="${js}/bootstrap.min.js" ></script>
<script src="${js}/bootstrap-table.js" ></script>
<script src="${js}/bootstrap-table-zh-CN.js" ></script>
<script src="${js}/bootstrap-table-export.js" ></script>
<script src="${js}/tableExport.js" ></script>
<script src="${js}/bootstrap-table-editable.js" ></script>
<script src="${js}/bootstrap-editable.min.js" ></script>
<script>
	$(document).ready(function() {
		var $table = $('#table'),
        	$remove = $('#remove'),
        	selections = [];
		$table.bootstrapTable({
			url : 'ajaxAllUser',
			height: $(window).height() - $('h1').outerHeight(true),
			pagination : true,
			search : true,
			searchOnEnterKey : true,
			showFooter : true,
			showColumns : true,
			showRefresh : true,
			showToggle : true,
			showPaginationSwitch : true,
			showExport : true,
			showFooter : true,
			detailView : true,
			detailFormatter : function(index, row){
				var html = [];
		        $.each(row, function (key, value) {
		            html.push('<p><b>' + key + ':</b> ' + value + '</p>');
		        });
		        return html.join('');
			},
			idField : "id",
			uniqueId : "id",
			clickToSelect : true,
			toolbar: "#toolbar",
			responseHandler : function (res) {
		        $.each(res, function (i, row) {
		            row.state = $.inArray(row.id, selections) !== -1;
		        });
		        return res;
		    },
			columns : [
		                [
		                    {
		                    	title: '状态',
		                        field: 'state',
		                        checkbox: true,
		                        rowspan: 2,
		                        align: 'center',
		                        valign: 'middle'
		                    }, {
		                        title: '用户ID',
		                        field: 'id',
		                        rowspan: 2,
		                        align: 'center',
		                        valign: 'middle',
		                        sortable: true,
		                        footerFormatter: function(data){return "总数";}
		                    }, {
		                        title: '详细信息',
		                        colspan: 3,
		                        align: 'center'
		                    }
		                ],
		                [
		                    {
		                        field: 'username',
		                        title: '用户名',
		                        sortable: true,
		                        editable: true,
		                        align: 'center',
		                        editable: {
		                            type: 'text',
		                            title: '用户名',
		                            validate: function (value) {
		                                value = $.trim(value);
		                                if (!value) {
		                                    return '不能为空';
		                                }
		                                var data = $table.bootstrapTable('getData'),
		                                    index = $(this).parents('tr').data('index');
		                                console.log(data[index]);
		                                return '';
		                            }
		                        },
		                        footerFormatter: function(data){return data.length;}
		                    }, {
		                        field: 'password',
		                        title: '密码',
		                        sortable: true,
		                        align: 'center',
		                        editable: {
		                            type: 'text',
		                            title: '密码',
		                            validate: function (value) {
		                                value = $.trim(value);
		                                if (!value) {
		                                    return '不能为空';
		                                }
		                                var data = $table.bootstrapTable('getData'),
		                                    index = $(this).parents('tr').data('index');
		                                console.log(data[index]);
		                                return '';
		                            }
		                        },
		                        footerFormatter: function(data){return data.length;}
		                    }, {
		                        field: 'operate',
		                        title: '操作',
		                        align: 'center',
		                        events: {
		                            'click .like': function (e, value, row, index) {
		                                alert('你点击了喜欢按钮，信息： ' + JSON.stringify(row));
		                            },
		                            'click .remove': function (e, value, row, index) {
		                            	$.post(
		                    	    			'${ctx}/backend/deleteuser',
		                    	    			{
		                    	    				userid : row.id,
		                    	    			}, function(data) {
		                    	    				if (data.code == '200') {
		                    	    					console.info('deleteuser:'+data.msg);
		                    	    					$table.bootstrapTable('remove', {
		        		                                    field: 'id',
		        		                                    values: [row.id]
		        		                                });
		                    	    				} else if (data.code == '400') {
		                    	    					alert(data.msg);
		                    	    					console.error('deleteuser:'+data.msg);	    					
		                    	    				}
		                    	    			},
		                    	    			// 默认返回字符串，设置值等于json则返回json数据
		                    	    			'json').error(function() {
		                    	    				alert("edit failed");
		                    	    				console.error('deleteuser:'+"edit failed");
		                    	    			});		                                	                                
		                            }
		                        },
		                        formatter: function(value, row, index) {
		                            return [
		                                    '<a class="like" href="javascript:void(0)" title="喜欢">',
		                                    '<i class="glyphicon glyphicon-heart"></i>',
		                                    '</a>  ',
		                                    '<a class="remove" href="javascript:void(0)" title="删除">',
		                                    '<i class="glyphicon glyphicon-remove"></i>',
		                                    '</a>'
		                                ].join('');
		                            }
		                    }
		                ]
		            ],
		});
		
		// sometimes footer render error.
		setTimeout(function () {
            $table.bootstrapTable('resetView');
        }, 200);
		
		$table.on('check.bs.table uncheck.bs.table ' +
                'check-all.bs.table uncheck-all.bs.table', function () {
            $remove.prop('disabled', !$table.bootstrapTable('getSelections').length);

            // save your data, here just save the current page
            selections = $.map($table.bootstrapTable('getSelections'), function (row) {
                return row.id
            });
            // push or splice the selections if you want to save all data selections
        });
		
		$table.on('all.bs.table', function (e, name, args) {
	        console.info(name, args);
	    });
		
		$table.on('editable-save.bs.table', function (e, name, args) {
			var field = name;
	        var obj = args;
	        $.post(
	    			'${ctx}/backend/updateuser',
	    			{
	    				userid : obj.id,
	    				username : obj.username,
	    				password : obj.password,
	    			}, function(data) {
	    				if (data.code == '200') {
	    					console.info('updateuser:'+data.msg);
	    				} else if (data.code == '400') {
	    					console.error('updateuser:'+data.msg);	    					
	    				}
	    			},
	    			// 默认返回字符串，设置值等于json则返回json数据
	    			'json').error(function() {
	    				console.error('updateuser:'+"failed");
	    			});
	    });		
		
		$remove.click(function () {
            var ids = $.map($table.bootstrapTable('getSelections'), function (row) {
                return row.id
            });
            $.post(
	    			'${ctx}/backend/deleteuserlist',
	    			{
	    				userlist : ids.toString(),
	    			}, function(data) {
	    				if (data.code == '200') {
	    		            $table.bootstrapTable('remove', {
	    		                field: 'id',
	    		                values: ids
	    		            });
	    		            $remove.prop('disabled', true);
	    					console.info('deletelist:'+data.msg);
	    				} else if (data.code == '400') {
	    					console.error('deletelist:'+data.msg);	    					
	    				}
	    			},
	    			// 默认返回字符串，设置值等于json则返回json数据
	    			'json').error(function() {
	    				console.error('deletelist:'+"failed");
	    			});
        });
		
        $(window).resize(function () {
            $table.bootstrapTable('resetView', {
                height: $(window).height() - $('h1').outerHeight(true)
            });
        });
	});
</script>
</head>

<body>
<div class="container-fluid">
	<div class="row-fluid">
		<div class="span12">
				<div id="toolbar">
        			<button id="remove" class="btn btn-danger" disabled>
            			<i class="glyphicon glyphicon-remove"></i> 删除
        			</button>
    			</div>
				<table id="table" ></table>
			</div>
		</div>
	</div>
</body>
</html>
