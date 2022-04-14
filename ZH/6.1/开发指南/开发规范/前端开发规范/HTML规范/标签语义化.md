<table class="table table-hover table-bordered table-header-bg f13"> 
    <caption>常见标签表</caption> 
    <thead> 
        <tr><th>标签</th><th>语义</th><th>嵌套常见错误</th><th>常用属性（加粗的为不可缺少的或建议属性）</th></tr> 
    </thead> 
    <tbody> 
        <tr><td>&lt;a&gt;&lt;/a&gt;</td><td>超链接/锚</td><td>a不可嵌套a</td><td>href,name,title,rel,target</td></tr> 
        <tr><td>&lt;br /&gt;</td><td>换行</td><td>&nbsp;</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;button&gt;&lt;/button&gt;</td><td>按钮</td><td>不可嵌套表单元素</td><td>type,disabled</td></tr> 
        <tr><td>&lt;dd&gt;&lt;/dd&gt;</td><td>定义列表中的定义（描述内容）</td><td>只能以dl为父容器，对应一个dt</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;del&gt;&lt;/del&gt;</td><td>文本删除</td><td>&nbsp;</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;div&gt;&lt;/div&gt;</td><td>块级容器</td><td>&nbsp;</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;dl&gt;&lt;/dl&gt;</td><td>定义列表</td><td>只能嵌套dt和dd</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;dt&gt;&lt;/dt&gt;</td><td>定义列表中的定义术语</td><td>只能以dl为父容器，对应多个dd</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;em&gt;&lt;/em&gt;</td><td>强调文本</td><td>&nbsp;</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;form&gt;&lt;/form&gt;</td><td>表单</td><td>&nbsp;</td><td><em>action</em>,target,method,name</td></tr> 
        <tr><td>&lt;h1&gt;&lt;/h1&gt;</td><td>标题</td><td>从h1到h6，不可嵌套块级元素</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;iframe&gt;&lt;/iframe&gt;</td><td>内嵌一个网页</td><td>&nbsp;</td><td>frameborder,width,height,src,scrolling,name</td></tr> 
        <tr><td>&lt;img /&gt;</td><td>图像</td><td>&nbsp;</td><td><em>alt</em>,src,width,height</td></tr> 
        <tr><td>&lt;input /&gt;</td><td>各种表单控件</td><td>&nbsp;</td><td><em>type</em>,name,value,checked,disabled,maxlength,readonly,accesskey</td></tr> 
        <tr><td>&lt;label&gt;&lt;/label&gt;</td><td>标签为input元素定义标注</td><td>&nbsp;</td><td>for</td></tr> 
        <tr><td>&lt;li&gt;&lt;/li&gt;</td><td>列表项</td><td>只能以ul或ol为父容器</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;link /&gt;</td><td>引用样式或icon</td><td>不可嵌套任何元素</td><td><em>type,rel</em>,href</td></tr> 
        <tr><td>&lt;meta /&gt;</td><td>文档信息</td><td>只用于head</td><td>content,http-equiv,name</td></tr> 
        <tr><td>&lt;ol&gt;&lt;/ol&gt;</td><td>有序列表</td><td>只能嵌套li</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;option&gt;&lt;/option&gt;</td><td>select中的一个选项</td><td>仅用于select</td><td><em>value</em>,selected,disabled</td></tr> 
        <tr><td>&lt;p&gt;&lt;/p&gt;</td><td>段落</td><td>不能嵌套块级元素</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;script&gt;&lt;/script&gt;</td><td>引用脚本</td><td>不可嵌套任何元素</td><td><em>type</em>,src</td></tr> 
        <tr><td>&lt;select&gt;&lt;/select&gt;</td><td>列表框或下拉框</td><td>只能嵌套option或optgroup</td><td>name,disabled,multiple</td></tr> 
        <tr><td>&lt;span&gt;&lt;/span&gt;</td><td>内联容器</td><td>&nbsp;</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;strong&gt;&lt;/strong&gt;</td><td>强调文本</td><td>&nbsp;</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;style&gt;&lt;/style&gt;</td><td>引用样式</td><td>不可嵌套任何元素</td><td><em>type</em>,media</td></tr> 
        <tr><td>&lt;sub&gt;&lt;/sub&gt;</td><td>下标</td><td>&nbsp;</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;sup&gt;&lt;/sup&gt;</td><td>上标</td><td>&nbsp;</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;table&gt;&lt;/table&gt;</td><td>表格</td><td>只可嵌套表格元素</td><td>width,align,background,cellpadding,cellspacing,summary,border</td></tr> 
        <tr><td>&lt;tbody&gt;&lt;/tbody&gt;</td><td>表格主体</td><td>只用于table</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;td&gt;&lt;/td&gt;</td><td>表格中的单元格</td><td>只用于tr</td><td>colspan,rowspan</td></tr> 
        <tr><td>&lt;textarea&gt;&lt;/textarea&gt;</td><td>多行文本输入控件</td><td>&nbsp;</td><td>name,accesskey,disabled,readonly,rows,cols</td></tr> 
        <tr><td>&lt;tfoot&gt;&lt;/tfoot&gt;</td><td>表格表尾</td><td>只用于table</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;th&gt;&lt;/th&gt;</td><td>表格中的标题单元格</td><td>只用于tr</td><td>colspan,rowspan</td></tr> 
        <tr><td>&lt;thead&gt;&lt;/thead&gt;</td><td>表格表头</td><td>只用于table</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;title&gt;&lt;/title&gt;</td><td>文档标题</td><td>只用于head</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;tr&gt;&lt;/tr&gt;</td><td>表格行</td><td>嵌套于table或thead、tbody、tfoot</td><td>&nbsp;</td></tr> 
        <tr><td>&lt;ul&gt;&lt;/ul&gt;</td><td>无序列表</td><td>只能嵌套li</td><td>&nbsp;</td></tr> 
    </tbody> 
</table>