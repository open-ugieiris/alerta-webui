<template>
  <div>
    <v-card>
      <v-card-title primary-title>
        <div>
          <div class="headline">
            {{ $t('TopFlapping') }}
          </div><br>
          <span class="grey--text">{{ $t('TopFlappingDescription') }}</span>
        </div>
        <v-spacer />
      </v-card-title>
      <v-data-table
        :headers="headers"
        :items="top10"
        class="px-2"
        hide-actions
      >
        <template
          slot="items"
          slot-scope="props"
        >
          <td>{{ props.item.event }}</td>
          <td class="text-xs-center">
            {{ props.item.count }}
          </td>
          <td class="text-xs-center">
            {{ props.item.duplicateCount }}
          </td>
          <td>{{ props.item.environments.join(', ') }}</td>
          <td>{{ props.item.services.join(', ') }}</td>
          <td>
            <span
              v-for="r in props.item.resources"
              :key="r.id"
            >
              <router-link :to="`/alert/${r.id}`">
                {{ r.resource }}
              </router-link>
            </span>
          </td>
        </template>
      </v-data-table>
    </v-card>
  </div>
</template>

<script>
import moment from 'moment'
import i18n from '@/plugins/i18n'

export default {
  data: () => ({
    headers: [
      {text: i18n.t('Event'), value: 'event', sortable: false},
      {text: i18n.t('Count'), value: 'count', sortable: false},
      {text: i18n.t('DuplicateCount'), value: 'duplicateCount', sortable: false},
      {text: i18n.t('Environment'), value: 'environment', sortable: false},
      {text: i18n.t('Services'), value: 'services', sortable: false},
      {text: i18n.t('Resources'), value: 'resources', sortable: false},
    ]
  }),
  computed: {
    top10() {
      return this.$store.state.alerts.flapping
    },
    refresh() {
      return this.$store.state.refresh
    }
  },
  watch: {
    refresh(val) {
      val || this.getTopFlapping()
    }
  },
  created() {
    this.getTopFlapping()
  },
  methods: {
    getTopFlapping() {
      return this.$store.dispatch('alerts/getTopFlapping')
    }
  }
}
</script>

<style></style>
