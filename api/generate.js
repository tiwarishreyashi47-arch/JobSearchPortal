const MODEL = 'gemini-2.5-flash';
const MAX_REQUEST_BYTES = 120000;

module.exports = async function handler(req, res) {
  res.setHeader('Cache-Control', 'no-store');

  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  if (!process.env.GEMINI_API_KEY) {
    return res.status(503).json({ error: 'The AI service is not configured yet.' });
  }

  try {
    const { systemInstruction, messages, generationConfig } = req.body || {};
    if (!systemInstruction || !Array.isArray(messages) || !messages.length) {
      return res.status(400).json({ error: 'Missing generation input.' });
    }

    const requestBytes = Buffer.byteLength(JSON.stringify(req.body), 'utf8');
    if (requestBytes > MAX_REQUEST_BYTES) {
      return res.status(413).json({
        error: 'This request is too large. Shorten the job description or profile context and try again.'
      });
    }

    const response = await fetch(
      `https://generativelanguage.googleapis.com/v1beta/models/${MODEL}:generateContent`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'x-goog-api-key': process.env.GEMINI_API_KEY,
        },
        body: JSON.stringify({
          system_instruction: { parts: [{ text: systemInstruction }] },
          contents: messages.map(message => ({
            role: message.role === 'assistant' ? 'model' : 'user',
            parts: [{ text: String(message.content || '') }],
          })),
          generationConfig: generationConfig || { maxOutputTokens: 3000, temperature: 0.7 },
        }),
      }
    );

    const data = await response.json();
    if (!response.ok || data.error) {
      return res.status(response.status || 502).json({
        error: data.error?.message || 'The AI service returned an error.',
      });
    }

    return res.status(200).json({
      text: data.candidates?.[0]?.content?.parts?.[0]?.text || '',
    });
  } catch (error) {
    return res.status(500).json({ error: error.message || 'Unable to generate content.' });
  }
}
