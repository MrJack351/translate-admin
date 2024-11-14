<template>
  <div class="code-editor">
    <textarea ref="textarea"></textarea>
  </div>
</template>

<script>
import Codemirror from 'codemirror'
import 'codemirror/lib/codemirror.css'
import 'codemirror/theme/dracula.css';  // 引入深色主题
import 'codemirror/mode/javascript/javascript'

export default {
  props: {
    value: {
      type: String,
      required: true
    },
    height: {
      type: String,
      default: '500px'  // 允许传入动态高度
    },
    options: {
      type: Object,
      default: () => ({
        mode: 'javascript',
        lineNumbers: true,
        theme: 'dracula',
      })
    }
  },
  mounted() {
    // 初始化CodeMirror
    this.editor = Codemirror.fromTextArea(this.$refs.textarea, {
      ...this.options
    });

    // 使用传入的高度
    this.editor.setSize('100%', this.height);

    this.editor.setValue(this.value)

    // 监听编辑器变化，并同步到父组件
    this.editor.on('change', () => {
      this.$emit('input', this.editor.getValue())
    })
  },
  watch: {
    value(newVal) {
      if (newVal !== this.editor.getValue()) {
        this.editor.setValue(newVal)
      }
    },
    height(newVal) {
      this.editor.setSize('100%', newVal)  // 动态更新高度
    }
  }
}
</script>

<style scoped>
.code-editor {
  margin-top: 10px;
}
</style>
