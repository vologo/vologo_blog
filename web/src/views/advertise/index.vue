<template>
  <div class="">
    <a-list
      :grid="{ gutter: 16, xs: 1, sm: 2, md: 4, lg: 4, xl: 6, xxl: 3 }"
      :data-source="advertiseList"
    >
      <a-list-item
        slot="renderItem"
        slot-scope="item"
      >
        <a-card :title="item.title">
          <a :href="item.link">{{ item.title }}</a>
        </a-card>
      </a-list-item>
    </a-list>
  </div>
</template>
<script>
import { createAdvertise, getSingleAdvertise, getAdvertise, setSingleAdvertise, deleteAdvertise } from '@/api/advertise'
export default {
  name: 'Advertise',
  components: {},
  props: {},
  data () {
    return {
      advertiseList: []
    }
  },
  computed: {},
  watch: {},
  created () {
    this.loadAdvertise()
  },
  mounted () { },
  methods: {
    async loadAdvertise () {
      const { data: res } = await getAdvertise({ page: this.page })
      console.log(res)
      this.advertiseList = res.data.data
      this.total = res.data.meta.total
    }
  }
}
</script>
<style rel="stylesheet/scss" lang="scss" scoped></style>
