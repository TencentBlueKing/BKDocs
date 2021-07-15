# 如何开发一个表格查询页面

## 第一步：画布中添加 Input、Table 组件

<img src="../assets/case-table1.png" />

## 第二步：为 Input 组件的值绑定变量

<img src="../assets/case-table2.png" />

<img src="../assets/case-table3.png" />

<img src="../assets/case-table4.png" />

## 第三步：为 Table 组件的数据属性和分页属性绑定变量

<img src="../assets/case-table5.png" />

<img src="../assets/case-table6.png" />

<img src="../assets/case-table7.png" />

<img src="../assets/case-table8.png" />

## 第四步：编写 Table 组件数据源获取函数 (getTableData)

<img src="../assets/case-table9.png" />

**编写函数时，编辑器除了支持 JS 本身的自动提示，还支持提示用户自己设置的函数、变量。**

<img src="../assets/case-table10.png" />

<img src="../assets/case-table11.png" />

## 第五步：Table 组件绑定数据源

<img src="../assets/case-table12.png" />

**远程函数获取数据后，发现画布中表格数据空了，这是因为数据返回生效了，而表格的列并没有和数据返回的列对应上，这里只需要设置表头配置即可**

<img src="../assets/case-table13.png" />

## 第六步：编写 Table 组件分页函数 (pageChange)

<img src="../assets/case-table14.png" />

<img src="../assets/case-table15.png" />

## 第七步：设置 Input 组件 change 事件，添加搜索功能

**由于在前面的 getTableData 函数中，我们已经设置 keyword 参数为 Input 组件绑定的 v-model 变量，因此这里直接将 Input 组件的 change 事件绑定为 getTableData 函数即可**

<img src="../assets/case-table16.png" />

## 第八步：拖拽完毕，预览查看最终效果

**页面加载时，发送异步请求，返回数据渲染表格**

<img src="../assets/case-table17.png" />

**翻页后，带上正确的翻页参数发送异步请求，返回数据渲染表格**

<img src="../assets/case-table18.png" />

**搜索框内容改变时，带上正确的搜索参数发送异步请求，返回数据渲染表格**

<img src="../assets/case-table19.png" />
