import request from '@/utils/request'

export function add(data) {
  return request({
    url: 'api/languageCodeMapping',
    method: 'post',
    data
  })
}
export function getLanguageMappingByCode(params) {
  return request({
    url: `api/languageCodeMapping/getLanguageMappingByCode`,
    params: params,
    method: 'get'
  })
}

export function updateAllCode(data) {
  return request({
    url: 'api/languageCodeMapping/updateAllCode',
    method: 'post',
    data
  })
}

export function del(ids) {
  return request({
    url: 'api/languageCodeMapping/',
    method: 'delete',
    data: ids
  })
}

export function edit(data) {
  return request({
    url: 'api/languageCodeMapping',
    method: 'put',
    data
  })
}

export default { add, edit, del }
