export const containsNumber = (text) => /\d{10}/.test(text);

export const containsURL = (text) => {
  if (!text) return false;
  const urlRegex = /(?:https?:\/\/|www\.)[^\s/$.?#].[^\s]*/i;
  const domainLikeRegex = /\b[a-z0-9-]+(?:\.[a-z]{2,})(?:\/\S*)?\b/i;
  return urlRegex.test(text) || domainLikeRegex.test(text);
};
