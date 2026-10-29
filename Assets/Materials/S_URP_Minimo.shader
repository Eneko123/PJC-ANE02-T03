
Shader "PJC/URP_Minimo"
{
    SubShader
    {
        Tags { "RenderPipeline" = "UniversalPipeline" "RenderType" = "Opaque" }

        Pass
        {
            HLSLPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            // Varyings vert(Attributes IN)
            // {
            //     Varyings OUT;
            //     OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);
            //     OUT.uv = IN.uv;
            //     return OUT;
            // }

            // Modificamos la altura de los v�rtices seg�n su posici�n en el eje X.
            
            Varyings vert(Attributes IN)
            {
                Varyings OUT;

                float3 position = IN.positionOS.xyz;
                position.y += position.x * 0.8;

                OUT.positionHCS = TransformObjectToHClip(position);
                OUT.uv = IN.uv;

                return OUT;
            }
            

            // half4 frag(Varyings IN) : SV_Target
            // {
            //     return half4(1.0, 0.0, 0.0, 1.0);
            // }
            // Las coordenadas UV se interpolan entre los v�rtices y llegan al fragment shader.
            // Utilizamos U para el canal rojo y V para el verde, generando un degradado de color.
            
                half4 frag(Varyings IN) : SV_Target
                {
                    return half4(IN.uv.x, IN.uv.y, 0.5, 0.5);
                }
            

            ENDHLSL
        }
    }
}
    