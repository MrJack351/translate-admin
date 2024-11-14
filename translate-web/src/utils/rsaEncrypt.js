import JSEncrypt from 'jsencrypt/bin/jsencrypt.min'

// 密钥对生成 http://web.chacuo.net/netrsakeypair

const publicKey = 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAg1Pkgn2IXGnOs6XTms2ww3nQQ7cyxPLwwWDv1lEApo6QcrIP3QniFE6oVI0KSv1qClbyNxpNJsCP+KurI9A3G3hycKl/+KrCYXm7sf9hXX4iBxbh1GabIvhhH0eC6yvzWM5xxYRuo/eHFajvnXfl422TlbwCEa82uXhBXguf0k4UDAhM0L3zJYf0jEUReNJyHeD2g27EQG6DrcrM14Miu7wAbbd5FINDrdu349QbphHSSfK6ok7SH2EL7XdhbwvfitzJ+4g738FxAKfv5Tb36v6w0YHvoyxyMcJ729nH5jooxnK+1h2Nugopjr69JGaWz2P+9z6aWxbW2maDlmfBbQIDAQAB'

// 加密
export function encrypt(txt) {
  const encryptor = new JSEncrypt()
  encryptor.setPublicKey(publicKey) // 设置公钥
  return encryptor.encrypt(txt) // 对需要加密的数据进行加密
}

