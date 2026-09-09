module display;

import color.convert;
import color.encoding;

public struct PreviewResult
{
    public float3 rgb;
    public bool isLegalLuma;
    public int encodingRevision;
    public int converterRevision;
    public int displayRevision;
}

public PreviewResult previewRec709Pixel(float3 ycbcr)
{
    PreviewResult result;
    YCbCrEncoding encoding = rec709LimitedRange();
    result.rgb = ycbcrToRgb(ycbcr, encoding);

    // The display layer uses color-encoding directly for validation. Conversion
    // also uses it, which gives the package graph its shared dependency.
    result.isLegalLuma = isLegalLumaSample(ycbcr.x);
    result.encodingRevision = encodingRevision();
    result.converterRevision = converterRevision();
    result.displayRevision = 100;
    return result;
}
