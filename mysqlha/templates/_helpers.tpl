{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 64 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 24 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 64 | trimSuffix "-" -}}
{{- end -}}

{{- define "mysqlha.labels" -}}
name: {{ template "fullname" . }}
app: {{ template "name" . }}
heritage: {{ .Release.Service | quote }}
release: {{ .Release.Name | quote }}
chart: {{ template "chartref" . }}
{{- end -}}

{{- define "chartref" -}}
  {{- replace "+" "_" .Chart.Version | printf "%s-%s" .Chart.Name -}}
{{- end -}}

{{/*
Create the name for our mysql configmap.
*/}}
{{- define "mysqlha.configmap" -}}
{{- printf "%s-configmap-%d" (include "fullname" .) .Release.Revision -}}
{{- end -}}
